//
//  MoodData+CoreDataProperties.swift
//  MoodMenuV1
//
//  Created by Matt Da Silva on 14/05/2024.
//
//

import Foundation
import CoreData


extension MoodData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoodData> {
        return NSFetchRequest<MoodData>(entityName: "MoodData")
    }

    @NSManaged public var dateTime: Date?
    @NSManaged public var generalMood: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var moodType: Int16
    @NSManaged public var note: String?
    
    var wrappedDateTime: Date {dateTime!}
    var wrappedGeneralMood: Int16 {generalMood}
    var wrappedID: UUID {id!}
    var wrappedMoodType: Int16 {moodType}
    var wrappedNote: String {note!}

}

extension MoodData : Identifiable {

}
