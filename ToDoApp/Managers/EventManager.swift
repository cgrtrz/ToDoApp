//
//  EventManager.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 15/12/2024.
//

import Foundation
import EventKit

final class EventManager {
    
    private let eventStore: EKEventStore = EKEventStore()
    private let reminder: EKReminder
    
    
    init () {
        reminder = EKReminder(eventStore: eventStore)
    }
    
    func addToCalendar(_ toDo: ToDo) throws {
        
        eventStore.requestFullAccessToEvents() {granted, error in
            if granted  && error == nil{
                print("events: good to go...")
                
                self.reminder.title = toDo.title
                self.reminder.isCompleted = toDo.isCompleted
                self.reminder.addAlarm(EKAlarm(relativeOffset: 15))
                self.reminder.notes = toDo.description_
                if Date(timeIntervalSince1970: toDo.dueDate!).distance(to: Date()) < -900 && toDo.dueDate != nil {
                    self.reminder.dueDateComponents = Calendar.current.dateComponents(
                        [
                            .year,
                            .month,
                            .day,
                            .hour,
                            .minute
                        ], from: Date(timeIntervalSince1970: toDo.dueDate!))
                } else {
                    //TODO: Throw error here...
                    //throw EventManagerError.invalidDueDate
                }
                self.eventStore.requestFullAccessToReminders() {granted, error in
                    if granted  && error == nil{
                        print("reminders: good to go...")
                        self.reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                        do {
                            try self.eventStore.save(self.reminder, commit: true)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
       
    }
}
