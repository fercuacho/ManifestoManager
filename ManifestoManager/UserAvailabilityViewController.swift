//
//  UserAvailabilityViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 30/12/23.
//

import UIKit
import FSCalendar

class UserAvailabilityViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var memberRecived : User?
    var teamRecived : Team?
    var dayRestrictions : [String: String]?
    var availability : [String] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var calendar: FSCalendar!
    
    var formatter = DateFormatter()
    
    /*let dayRestrictions = [
        "Sunday": "Cerrado",
        "Monday": "9:00-17:00",
        "Tuesday": "10:30-11:20",
        "Wednesday": "9:00-17:00",
        "Thursday": "9:00-12:00",
        "Friday": "Cerrado",
        "Saturday": "Cerrado"
    ]*/

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        //disableClosedDays(for: calendar)
        print("los dias restriccion son")
        print(dayRestrictions ?? "nada")

        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MM-yyyy"
        let fecha = formatter.string(from: date)
        print("Date De-Selected == ", fecha)
        if !availability.contains(fecha) {
            availability.append(String(fecha))
        }
        print("la disponibilidad es :", availability)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MM-yyyy"
        let fecha = formatter.string(from: date)
        print("Date De-Selected == ", fecha)
        if availability.contains(fecha) {
            availability.removeAll{ $0 == (String(fecha))}
        }
        print("la disponibilidad es :", availability)
    }
    
    @IBAction func verlista(_ sender: Any) {
        
        print("la lista es: ")
        if (availability != nil) {
            print(availability as Any)
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        formatter.dateFormat = "dd-MM-yyyy"
        /*guard let excludedDate = formatter.date(from: "23-12-2023") else {return true}
        if date.compare(excludedDate) == .orderedSame {
            return false
        }
        return true*/
        
        formatter.dateFormat = "EEEE"

           let dayOfWeek = formatter.string(from: date)

        if let restriction = dayRestrictions?[dayOfWeek], restriction == "Closed" {
               return false
           }

           return true
    }
    
    
    @IBAction func saveAvailabilityBtn(_ sender: Any) {
        
        let person = memberRecived
        
        let concatenatedString = availability.joined(separator: ", ")
        
        person?.availability = concatenatedString
        //Save the data
        do{
            try self.context.save()
        }
        catch{
            
        }
        
    }
    
    /*func disableClosedDays(for calendar: FSCalendar) {
        let currentDate = calendar.currentPage

        let calendarDays = Calendar.current.range(of: .day, in: .month, for: currentDate) ?? 1..<1
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Obtener el nombre del día de la semana

        for day in calendarDays {
            guard let date = Calendar.current.date(bySetting: .day, value: day, of: currentDate) else { continue }
            let dayOfWeek = formatter.string(from: date)

            if let restriction = dayRestrictions?[dayOfWeek], restriction == "Cerrado" {
                if let cell = calendar.cell(for: date, at: .current) {
                    cell.appearance.titleDefaultColor = UIColor.lightGray
                }
            }
        }
    }*/


    
    

}
