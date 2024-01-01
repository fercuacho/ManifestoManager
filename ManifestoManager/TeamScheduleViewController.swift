//
//  TeamScheduleViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 31/12/23.
//

import UIKit
import FSCalendar

class TeamScheduleViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    var formatter = DateFormatter()

    struct CalendarEvent {
        var date: Date
        var title: String
        var color: UIColor // Agrega una propiedad para el color del evento
    }

    var calendarEvents: [CalendarEvent] = []

    @IBOutlet weak var calendar: FSCalendar!

    @IBOutlet weak var scheduleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")

        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        
        scheduleTable.delegate = self
        scheduleTable.dataSource = self

        let dateString = "24-12-2023"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        if let fecha = dateFormatter.date(from: dateString) {
            addEventToCalendar(date: fecha, title: "Evento 1", color: .red)
            addEventToCalendar(date: fecha, title: "Evento 2", color: .blue)
            // Agrega más eventos con colores diferentes según sea necesario
        }
    }

    func addEventToCalendar(date: Date, title: String, color: UIColor) {
        let event = CalendarEvent(date: date, title: title, color: color)
        calendarEvents.append(event)

        // Vuelve a cargar el calendario para reflejar los cambios
        calendar.reloadData()
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)

        // Verifica si hay eventos en la fecha actual y personaliza la apariencia de la celda
        let eventsForDate = events(for: date)
        if !eventsForDate.isEmpty {
            cell.eventIndicator.isHidden = false
            //cell.eventIndicator.numberOfEvents = eventsForDate.count
            //cell.eventIndicator.color = eventsForDate.first?.color
            cell.eventIndicator.color = eventsForDate.map { $0.color }

        } else {
            cell.eventIndicator.isHidden = true
        }

        return cell
    }
    
    

    func events(for date: Date) -> [CalendarEvent] {
        // Filtra los eventos para la fecha dada
        return calendarEvents.filter { $0.date == date }
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Puedes mostrar los detalles de los eventos aquí o navegar a otro controlador de vista
        let eventsForDate = events(for: date)
        for event in eventsForDate {
            print("Evento seleccionado: \(event.title) en \(event.date)")
        }
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // Devuelve el número de eventos para la fecha dada
        return events(for: date).count
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
           // Devuelve los colores de selección de eventos para la fecha dada
           let eventsForDate = events(for: date)
           return eventsForDate.map { $0.color }
       }
    
    
    
}

extension TeamScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCellShiftTableViewCell
        
        return cell
    }
    
    
    
}



/*
import UIKit
import FSCalendar

class TeamScheduleViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    //var calendar:FSCalendar!
    var formatter = DateFormatter()

    struct CalendarEvent {
        var date: Date
        var title: String
        // Puedes agregar más propiedades según tus necesidades
    }
    
    var calendarEvents: [CalendarEvent] = []

    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")

        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        
        let dateString = "24-12-2023"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let fecha = dateFormatter.date(from: dateString) {
            // La variable 'fecha' ahora contiene un objeto Date para la fecha especificada
            print(fecha)
            addEventToCalendar(date: fecha, title: "a ver si sirve")
            addEventToCalendar(date: fecha, title: "evento2")

        }
        
        //calendar.allowsMultipleSelection = true
        
    }
    
    func addEventToCalendar(date: Date, title: String) {
        let event = CalendarEvent(date: date, title: title)
        calendarEvents.append(event)

        // Vuelve a cargar el calendario para reflejar los cambios
        calendar.reloadData()
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)

        // Verifica si hay un evento en la fecha actual y personaliza la apariencia de la celda
        if hasEvent(for: date) {
            // Puedes cambiar el color de fondo u otras propiedades de la celda para indicar que hay un evento
            //cell.backgroundColor = UIColor.blue
            cell.eventIndicator.numberOfEvents = calendarEvents.count
            cell.eventIndicator.isHidden = false
            cell.eventIndicator.color = UIColor.red

        }else {
            cell.eventIndicator.isHidden = true
        }

        return cell
    }
    
    func hasEvent(for date: Date) -> Bool {
        // Verifica si hay un evento en la fecha actual
        return calendarEvents.contains { $0.date == date }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Puedes mostrar los detalles del evento aquí o navegar a otro controlador de vista
        if let event = calendarEvents.first(where: { $0.date == date }) {
            print("Evento seleccionado: \(event.title) en \(event.date)")
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            // Devuelve el número de eventos para la fecha dada
        return calendarEvents.contains { event in
               // Comparar si la fecha del evento coincide con la fecha dada
               
            return event.date == date
           } ? 1 : 0
        
    }
}

*/
