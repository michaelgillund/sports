//
//  SceneDelegate.swift
//  FinalProject
//
//  Created by Michael Gillund on 2/16/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .dark
        
        let controller = HomeViewController()
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

protocol SectionSelectionViewControllerDelegate: AnyObject {
    func sectionSelectionViewControllerDidFinish(_ controller: SectionSelectionViewController, selectedSections: [String])
}

class SectionSelectionViewController: UITableViewController {
    
    var sections: [String] = []
    var selectedSections: [String] = []
    weak var delegate: SectionSelectionViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        sections.append("NFL")
        sections.append("NBA")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let section = sections[indexPath.row]
        cell.textLabel?.text = section
        if selectedSections.contains(section) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        if selectedSections.contains(section) {
            selectedSections.removeAll(where: { $0 == section })
        } else {
            selectedSections.append(section)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.sectionSelectionViewControllerDidFinish(self, selectedSections: selectedSections)
        dismiss(animated: true, completion: nil)
    }
}

class ViewController: UIViewController, UITableViewDataSource, SectionSelectionViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var allSections = ["Section A", "Section B", "Section C", "Section D"]
    var selectedSections = [String]()
    var filteredSections = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self

        filteredSections = allSections
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredSections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row + 1)"
        return cell
    }

    // MARK: - Actions

    @IBAction func filterBySection(_ sender: UIButton) {
        let sectionSelectionVC = SectionSelectionViewController()
        sectionSelectionVC.sections = allSections
        sectionSelectionVC.selectedSections = selectedSections
        sectionSelectionVC.delegate = self
        let navController = UINavigationController(rootViewController: sectionSelectionVC)
        present(navController, animated: true, completion: nil)
    }

    // MARK: - SectionSelectionViewControllerDelegate

    func sectionSelectionViewControllerDidFinish(_ controller: SectionSelectionViewController, selectedSections: [String]) {
        self.selectedSections = selectedSections
        if selectedSections.isEmpty {
            filteredSections = allSections
        } else {
            filteredSections = allSections.filter { selectedSections.contains($0) }
        }
        tableView.reloadData()
    }
}
