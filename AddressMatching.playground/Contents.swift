import UIKit
import Foundation
/*
 This is address Matching using NSDataDetector. This does not recognize Names. For that
 we may have to use NSLinguisticTagger
 */

//https://nshipster.com/nsdatadetector/

let string = """
   Gregory Doe, My flight (AA10) is scheduled for tomorrow night from 9 PM PST to 5 AM EST.
   I'll be staying at The Plaza Hotel, 768 5th Ave, New York, NY 10019.
   You can reach me at 555-555-1234 or me@example.com
"""
let detector = try NSDataDetector(types: NSTextCheckingAllTypes)
let range = NSRange(string.startIndex..<string.endIndex, in: string)
detector.enumerateMatches(in: string,
                          options: [],
                          range: range) { (match, flags, _) in
    guard let match = match else {
        return
    }

    switch match.resultType {
    case .date:
        let date = match.date
        if let date = date {
            print(date)
        }
        let timeZone = match.timeZone
        if let timeZone = timeZone {
            print(timeZone)
        }
        let duration = match.duration
        
    
            print(duration)
        

    case .address:
        if let components = match.components {
            let name = components[.name]
            if let name = name {
                print(name)
            }
            let jobTitle = components[.jobTitle]
            if let jobTitle = jobTitle {
                print(jobTitle)
            }
            let organization = components[.organization]
            if let organization = organization {
                print(organization)
            }
            let street = components[.street]
            if let street = street {
                print(street)
            }
            let locality = components[.city]
            if let locality = locality {
                print(locality)
            }
            let region = components[.state]
            if let region = region {
                print(region)
            }
            let postalCode = components[.zip]
            if let postalCode = postalCode {
                print(postalCode)
            }
            let country = components[.country]
            if let country = country {
                print(country)
            }
            let phoneNumber = components[.phone]
            if let phoneNumber = phoneNumber {
                print(phoneNumber)
            }
           // print(name, jobTitle, organization, street, locality, region, postalCode, country, phoneNumber)
        }
    case .link:
        let url = match.url
        if let url = url{
        print(url)
        }
    case .phoneNumber:
        let phoneNumber = match.phoneNumber
        if let phoneNumber = phoneNumber{
        print(phoneNumber)
        }
    case .transitInformation:
        if let components = match.components {
            let airline = components[.airline]
            let flight = components[.flight]
            if let airline = airline, let flight = flight {
            print(airline, flight)
            }
        }
    default:
        return
    }
}
