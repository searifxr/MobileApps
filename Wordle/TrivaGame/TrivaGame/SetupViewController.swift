//
//  SetupViewController.swift
//  TrivaGame
//
//  Created by Pothapragada, Krishna N on 1/7/26.
//

import UIKit





struct OpenTriviaResponse: Decodable {

    let response_code: Int

    let results: [OpenTriviaQuestion]

}



struct OpenTriviaQuestion: Decodable {

    let category: String

    let type: String

    let difficulty: String

    let question: String

    let correct_answer: String

    let incorrect_answers: [String]

}



class SetupViewController: UIViewController, URLSessionDelegate {

    

    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var startButton: UIButton!

    

    @IBOutlet weak var sourceSegmentedControl: UISegmentedControl!

    

    lazy var relaxedSession: URLSession = {

        let config = URLSessionConfiguration.default

        return URLSession(configuration: config, delegate: self, delegateQueue: nil)

    }()

    

    var categories: [String] = []

    let questionCounts = [5, 10, 15, 20]

    let openTDBCategoryIDs: [String: Int] = [

        "General Knowledge": 9,

        "Entertainment: Books": 10,

        "Entertainment: Film": 11,

        "Entertainment: Music": 12,

        "Entertainment: Musicals & Theatres": 13,

        "Entertainment: Television": 14,

        "Entertainment: Video Games": 15,

        "Entertainment: Board Games": 16,

        "Science & Nature": 17,

        "Science: Computers": 18,

        "Science: Mathematics": 19,

        "Mythology": 20,

        "Sports": 21,

        "Geography": 22,

        "History": 23,

        "Politics": 24,

        "Art": 25,

        "Celebrities": 26,

        "Animals": 27,

        "Vehicles": 28,

        "Entertainment: Comics": 29,

        "Science: Gadgets": 30,

        "Entertainment: Japanese Anime & Manga": 31,

        "Entertainment: Cartoon & Animations": 32

    ]

    

    

    enum QuestionSource {

        case local

        case online

    }

    

    var currentSource: QuestionSource {

        return sourceSegmentedControl.selectedSegmentIndex == 0 ? .local : .online

    }

    

    override func viewDidLoad() {

        super.viewDidLoad()

        

        categories = TriviaGame.getCategories()

        

        pickerView.dataSource = self

        pickerView.delegate = self

        

        pickerView.selectRow(0, inComponent: 0, animated: false)

        pickerView.selectRow(0, inComponent: 1, animated: false)

        

        sourceSegmentedControl.selectedSegmentIndex = 0

    }

    

    @IBAction func startGameTapped(_ sender: UIButton) {

        let countRow = pickerView.selectedRow(inComponent: 1)

        guard questionCounts.indices.contains(countRow) else { return }

        let numberOfQuestions = questionCounts[countRow]

        

        switch currentSource {

        case .local:

            startLocalGame(numberOfQuestions: numberOfQuestions)

        case .online:

            startOnlineGame(numberOfQuestions: numberOfQuestions)

        }

    }

    

    private func showOnlineErrorAlert(message: String = "Couldn’t load online questions for this setup. Try a different category, fewer questions, or switch to Local mode.") {

        let alert = UIAlertController(

            title: "Online Mode Error",

            message: message,

            preferredStyle: .alert

        )

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)

    }

    

    func urlSession(_ session: URLSession,

                    didReceive challenge: URLAuthenticationChallenge,

                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        

        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,

           let trust = challenge.protectionSpace.serverTrust {

            let credential = URLCredential(trust: trust)

            completionHandler(.useCredential, credential)

        } else {

            completionHandler(.performDefaultHandling, nil)

        }

    }

    

    

    private func startLocalGame(numberOfQuestions: Int) {

        guard let tabBar = tabBarController as? GameTabBarController else { return }

        

        let categoryRow = pickerView.selectedRow(inComponent: 0)

        guard categories.indices.contains(categoryRow) else { return }

        let category = categories[categoryRow]

        

        let db = TriviaGame.getQuestionDB()

        guard let allQuestions = db[category], !allQuestions.isEmpty else { return }

        

        let chosen = Array(allQuestions.shuffled().prefix(numberOfQuestions))

        

        let config = GameConfig(

            category: category,

            numberOfQuestions: chosen.count,

            questions: chosen,

            currentIndex: 0,

            correctCount: 0,

            score: 0,

            currentStreak: 0,

            maxStreak: 0

        )

        

        tabBar.currentGame = config
        print("✅ Game created with \(config.questions.count) questions")
        tabBar.selectedIndex = 1

    }

    

    private func startOnlineGame(numberOfQuestions: Int) {

        guard let tabBar = tabBarController as? GameTabBarController else { return }

        

        startButton.isEnabled = false

        

        // Which category did we pick?

        let categoryRow = pickerView.selectedRow(inComponent: 0)

        let chosenCategoryName = categories.indices.contains(categoryRow) ? categories[categoryRow] : nil

        let categoryID = chosenCategoryName.flatMap { openTDBCategoryIDs[$0] }

        

        // Base URL

        var urlString = "https://opentdb.com/api.php?amount=\(numberOfQuestions)&type=multiple&encode=url3986"

        

        if let id = categoryID {

            urlString += "&category=\(id)"

        }

        // If you later add difficulty:

        // urlString += "&difficulty=hard"

        

        print("🔍 OpenTDB URL: \(urlString)")

        

        guard let url = URL(string: urlString) else {

            startButton.isEnabled = true

            showOnlineErrorAlert(message: "Invalid URL for OpenTDB request.")

            return

        }

        

        relaxedSession.dataTask(with: url) { [weak self, weak tabBar] data, response, error in

            guard let self = self else { return }

            

            DispatchQueue.main.async {

                self.startButton.isEnabled = true

            }

            

            if let error = error {

                print("OpenTDB error:", error)

                DispatchQueue.main.async {

                    self.showOnlineErrorAlert(message: "Network error: \(error.localizedDescription)")

                }

                return

            }

            

            guard let data = data else {

                DispatchQueue.main.async {

                    self.showOnlineErrorAlert(message: "No data was returned from OpenTDB.")

                }

                return

            }

            

            do {

                let decoded = try JSONDecoder().decode(OpenTriviaResponse.self, from: data)

                

                guard decoded.response_code == 0 else {

                    print("OpenTDB response_code:", decoded.response_code)

                    DispatchQueue.main.async {

                        self.showOnlineErrorAlert(

                            message: "OpenTDB couldn’t find enough questions for this setup (code \(decoded.response_code)). Try fewer questions or a different category."

                        )

                    }

                    return

                }

                

                let triviaQuestions: [Trivia] = decoded.results.map { q in

                    let question = q.question.removingPercentEncoding ?? q.question

                    let correct = q.correct_answer.removingPercentEncoding ?? q.correct_answer

                    let incorrect = q.incorrect_answers.map { $0.removingPercentEncoding ?? $0 }

                    

                    return Trivia(

                        q: question,

                        correct: correct,

                        incorrect: incorrect

                    )

                }

                

                DispatchQueue.main.async {

                    guard let tabBar = tabBar, !triviaQuestions.isEmpty else {

                        self.showOnlineErrorAlert(message: "OpenTDB returned 0 questions. Try different settings.")

                        return

                    }

                    

                    let config = GameConfig(

                        category: chosenCategoryName ?? "Online (OpenTDB)",

                        numberOfQuestions: triviaQuestions.count,

                        questions: triviaQuestions,

                        currentIndex: 0,

                        correctCount: 0,

                        score: 0,

                        currentStreak: 0,

                        maxStreak: 0

                    )

                    

                    tabBar.currentGame = config

                    tabBar.selectedIndex = 1

                }

                

            } catch {

                print("Failed to decode OpenTDB:", error)

                DispatchQueue.main.async {

                    self.showOnlineErrorAlert(message: "Failed to decode trivia data from OpenTDB.")

                }

            }

        }.resume()

    }

    @IBAction func unwindToSetup(_ segue: UIStoryboardSegue) {

        if let tabBar = tabBarController as? GameTabBarController {

            tabBar.currentGame = nil

        }

        

        tabBarController?.selectedIndex = 0

    }

}





extension SetupViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 2

    }

    

    func pickerView(_ pickerView: UIPickerView,

                    numberOfRowsInComponent component: Int) -> Int {

        return component == 0 ? categories.count : questionCounts.count

    }

    

    func pickerView(_ pickerView: UIPickerView,

                    titleForRow row: Int,

                    forComponent component: Int) -> String? {

        if component == 0 {

            return categories[row]

        } else {

            return "\(questionCounts[row])"

        }

    }

    

    func pickerView(_ pickerView: UIPickerView,

                    widthForComponent component: Int) -> CGFloat {

        let totalWidth = pickerView.bounds.width

        return component == 0 ? totalWidth * 0.7 : totalWidth * 0.3

    }

}
