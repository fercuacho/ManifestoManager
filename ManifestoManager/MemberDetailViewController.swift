//
//  MemberDetailViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 31/12/23.
//

import UIKit

class MemberDetailViewController: UIViewController {

    var memberRecived : User?
    var teamRecived : Team?
    
    var restrictionDays : [String: String]?


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratePerHourTx: UITextField!
    @IBOutlet weak var maxHoursMonthTx: UITextField!
    @IBOutlet weak var changeColorBtn: UIButton!
    @IBOutlet weak var saveChangesBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = memberRecived?.name
        
    }
    
    @IBAction func verDisponibilidad(_ sender: Any) {
        print("la disponibilidad de: ", memberRecived?.name ?? "user")
        print(memberRecived?.availability ?? "nada")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UserAvailabilityViewController
        destination.teamRecived = teamRecived
        destination.memberRecived = memberRecived
        restrictionDays = getDayRestrictions(for: teamRecived ?? Team())
        destination.dayRestrictions = restrictionDays

    }

    @IBAction func openCalendarBtn(_ sender: Any) {
        //print(teamRecived?.openingHours ?? "nada")
        //        restrictionDays = getDayRestrictions(for: teamRecived ?? Team())
        //print(restrictionDays ?? "nada")
        self.performSegue(withIdentifier: "openCalendarSegue", sender: Self.self)
    }
    

    func getDayRestrictions(for team: Team) -> [String: String] {
        var dayRestrictions = [String: String]()

        if let openingHoursSet = team.openingHours as? Set<Availability> {
            let openingHoursArray = Array(openingHoursSet)

            for openingHours in openingHoursArray {
                // Aquí asumimos que dayOfWeek es único para cada apertura de horarios
                let dayOfWeek = openingHours.dayOfWeek ?? ""
                let openingHoursString = openingHours.openingHour ?? ""

                dayRestrictions[dayOfWeek] = openingHoursString
            }
        }

        return dayRestrictions
    }

    
}
