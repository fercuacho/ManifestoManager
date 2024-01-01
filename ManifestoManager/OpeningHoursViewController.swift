//
//  OpeningHoursViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 29/12/23.
//

import UIKit

class OpeningHoursViewController: UIViewController {

    var teamRecived2 : Team?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var ClosedLabelMonday: UILabel!
    @IBOutlet weak var SMonday: UISwitch!
    @IBOutlet weak var TPMon1: UIDatePicker!
    @IBOutlet weak var TPMon2: UIDatePicker!
    @IBOutlet weak var toMon: UILabel!
    
    @IBOutlet weak var ClosedLabelTuesday: UILabel!
    @IBOutlet weak var STuesday: UISwitch!
    @IBOutlet weak var TPTues1: UIDatePicker!
    @IBOutlet weak var TPTues2: UIDatePicker!
    @IBOutlet weak var toTues: UILabel!
    
    @IBOutlet weak var ClosedLabelWednesday: UILabel!
    @IBOutlet weak var SWednesday: UISwitch!
    @IBOutlet weak var TPWed1: UIDatePicker!
    @IBOutlet weak var TPWed2: UIDatePicker!
    @IBOutlet weak var toWed: UILabel!
    
    @IBOutlet weak var ClosedLabelThursday: UILabel!
    @IBOutlet weak var SThursday: UISwitch!
    @IBOutlet weak var toThurs: UILabel!
    @IBOutlet weak var TPThurs2: UIDatePicker!
    @IBOutlet weak var TPThurs1: UIDatePicker!
    
    @IBOutlet weak var ClosedLabelFriday: UILabel!
    @IBOutlet weak var TPFri1: UIDatePicker!
    @IBOutlet weak var SFriday: UISwitch!
    @IBOutlet weak var TPFri2: UIDatePicker!
    @IBOutlet weak var toFri: UILabel!
    
    @IBOutlet weak var ClosedLabelSaturday: UILabel!
    @IBOutlet weak var SSaturday: UISwitch!
    @IBOutlet weak var TPSat1: UIDatePicker!
    @IBOutlet weak var TPSat2: UIDatePicker!
    @IBOutlet weak var toSat: UILabel!
    
    @IBOutlet weak var ClosedLabelSunday: UILabel!
    @IBOutlet weak var SSunday: UISwitch!
    @IBOutlet weak var TPSun1: UIDatePicker!
    @IBOutlet weak var TPSun2: UIDatePicker!
    @IBOutlet weak var toSun: UILabel!
    
    
    
    struct DayElements {
            var switchElement: UISwitch
            var datePicker1: UIDatePicker
            var datePicker2: UIDatePicker
            var closedLabel: UILabel
            var toLabel: UILabel
        }
        
        var mondayElements: DayElements!
        var tuesdayElements: DayElements!
        var wednesdayElements: DayElements!
        var thursdayElements: DayElements!
        var fridayElements: DayElements!
        var saturdayElements: DayElements!
        var sundayElements: DayElements!
    
    
        var availability: [Availability] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            if (teamRecived2 != nil){
                titlelabel.text = teamRecived2?.name
            }
            // Configurar los elementos relacionados con el lunes
            mondayElements = DayElements(
                switchElement: SMonday,
                datePicker1: TPMon1,
                datePicker2: TPMon2,
                closedLabel: ClosedLabelMonday,
                toLabel: toMon
            )
            mondayElements.switchElement.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

            // Configurar los elementos relacionados con el martes
            tuesdayElements = DayElements(
                switchElement: STuesday,
                datePicker1: TPTues1,
                datePicker2: TPTues2,
                closedLabel: ClosedLabelTuesday,
                toLabel: toTues
            )
            tuesdayElements.switchElement.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            
            // Configurar los elementos relacionados con el miércoles
            wednesdayElements = DayElements(
                        switchElement: SWednesday,
                        datePicker1: TPWed1,
                        datePicker2: TPWed2,
                        closedLabel: ClosedLabelWednesday,
                        toLabel: toWed
                    )
                    wednesdayElements.switchElement.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

                    // Configurar los elementos relacionados con el jueves
                    thursdayElements = DayElements(
                        switchElement: SThursday,
                        datePicker1: TPThurs1,
                        datePicker2: TPThurs2,
                        closedLabel: ClosedLabelThursday,
                        toLabel: toThurs
                    )
                    thursdayElements.switchElement.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

                    // Configurar los elementos relacionados con el viernes
                    fridayElements = DayElements(
                        switchElement: SFriday,
                        datePicker1: TPFri1,
                        datePicker2: TPFri2,
                        closedLabel: ClosedLabelFriday,
                        toLabel: toFri
                    )
                    fridayElements.switchElement.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

                    // Configurar los elementos relacionados con el sábado
                    saturdayElements = DayElements(
                        switchElement: SSaturday,
                        datePicker1: TPSat1,
                        datePicker2: TPSat2,
                        closedLabel: ClosedLabelSaturday,
                        toLabel: toSat
                    )
                    saturdayElements.switchElement.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

                    // Configurar los elementos relacionados con el domingo
                    sundayElements = DayElements(
                        switchElement: SSunday,
                        datePicker1: TPSun1,
                        datePicker2: TPSun2,
                        closedLabel: ClosedLabelSunday,
                        toLabel: toSun
                    )
                    sundayElements.switchElement.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
                }

        @objc func switchValueChanged(_ sender: UISwitch) {
            updateDayElementsVisibility(dayElements: getDayElements(for: sender), switchState: sender.isOn)
        }

        func getDayElements(for switchElement: UISwitch) -> DayElements {
            switch switchElement {
            case SMonday:
                return mondayElements
            case STuesday:
                return tuesdayElements
            case SWednesday:
                return wednesdayElements
            case SThursday:
                return thursdayElements
            case SFriday:
                return fridayElements
            case SSaturday:
                return saturdayElements
            case SSunday:
                return sundayElements
            default:
                fatalError("Switch not recognized")
            }
        }	

    @IBAction func saveChanges(_ sender: Any) {
        availability.removeAll()

            // Configura el arreglo de disponibilidad
            configureAvailability(for: mondayElements, dayOfWeek: "Monday")
            configureAvailability(for: tuesdayElements, dayOfWeek: "Tuesday")
            configureAvailability(for: wednesdayElements, dayOfWeek: "Wednesday")
            configureAvailability(for: thursdayElements, dayOfWeek: "Thursday")
            configureAvailability(for: fridayElements, dayOfWeek: "Friday")
            configureAvailability(for: saturdayElements, dayOfWeek: "Saturday")
            configureAvailability(for: sundayElements, dayOfWeek: "Sunday")

        teamRecived2?.openingHours = NSSet(array: availability)

        // Guardar el contexto de Core Data
        do {
            try context.save()
        } catch {
            // Manejar el error
            print("Error saving context: \(error.localizedDescription)")
        }
        
        
                // Imprime el resultado (puedes guardar esto en tu modelo de datos)
                for day in availability {
                    print(day)
                }
    }
    
    func configureAvailability(for dayElements: DayElements, dayOfWeek: String) {
            let switchState = dayElements.switchElement.isOn
            let startTime = dayElements.datePicker1.date
            let endTime = dayElements.datePicker2.date

            let openingHour: String
            if switchState {
                openingHour = formatAvailability(startTime: startTime, endTime: endTime)
            } else {
                openingHour = "Closed"
            }

        let dayAvailability = Availability(context: self.context)
            dayAvailability.dayOfWeek = dayOfWeek
            dayAvailability.openingHour = openingHour
            availability.append(dayAvailability)
        }

        func formatAvailability(startTime: Date, endTime: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let startTimeString = dateFormatter.string(from: startTime)
            let endTimeString = dateFormatter.string(from: endTime)
            return "\(startTimeString) - \(endTimeString)"
        }
    
    
    func updateDayElementsVisibility(dayElements: DayElements, switchState: Bool) {
            dayElements.datePicker1.isHidden = !switchState
            dayElements.datePicker2.isHidden = !switchState
            dayElements.closedLabel.text = switchState ? "Open" : "Closed"
            dayElements.toLabel.isHidden = !switchState
        }
    


}
