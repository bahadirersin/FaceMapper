//
//  AddInfoView.swift
//  FaceMapper
//
//  Created by Bahadır Ersin on 14.03.2023.
//
import MapKit
import SwiftUI

struct AddInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.504, longitude: -0.11), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    @ObservedObject var persons:PersonList
    @State var currentRegion: MKCoordinateRegion
    @State var name:String=""
    @State var image:Image?
    
    var body: some View {
        Form{
            VStack(alignment:.leading){
                Text("Image:")
                    .fontWeight(.bold)
                image?
                    .resizable()
                    .scaledToFit()
            }
            
            
            HStack(alignment:.center){
                Text("Person Name:")
                    .fontWeight(.bold)
                TextField("Name", text: $name)
            }
            
            VStack(alignment:.leading){
                Text("Meeting Location:")
                    .fontWeight(.bold
                    )
                ZStack{
                    Map(coordinateRegion:$currentRegion)
                        .frame(width:300,height:300)
                        .interactiveDismissDisabled(true)
                    
                    Circle()
                        .frame(width:20,height:20)
                        .foregroundColor(.red.opacity(0.5))
                }
            }

            
            Button("Save"){
                persons.personList.append(Person(name: name, imageURL: URL(string: "")!, longitude: currentRegion.center.longitude, latitude: currentRegion.center.latitude))
                dismiss()
            }
        }
    }
}

struct AddInfoView_Previews: PreviewProvider {
    
    static var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.504, longitude: -0.11), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    
    static var previews: some View {
        AddInfoView(persons: PersonList(), currentRegion: mapRegion)
    }
}
