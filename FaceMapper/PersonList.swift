//
//  PersonList.swift
//  FaceMapper
//
//  Created by Bahadır Ersin on 14.03.2023.
//

import Foundation

class PersonList:ObservableObject{
    @Published var personList:[Person] = [Person]()
}
