//
//  Error Messages.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/19/21.
//

import Foundation
enum ErroMessage : String, Error{
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidURL = "Not a valid URL"
}
