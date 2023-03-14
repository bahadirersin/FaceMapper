//
//  ContentView.swift
//  FaceMapper
//
//  Created by Bahadır Ersin on 14.03.2023.
//
import CoreLocation
import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject var locationFetcher = LocationFetcher()
    @StateObject var persons = PersonList()
    
    @State var showPickerSheet = false
    @State var inputImage:UIImage?
    @State var showAddInfoSheet = false
    @State var showAdditionalInfoSheet = false
    
    var body: some View {
        
//  Beginning of body
        NavigationView{
            VStack{
                List{
                    ForEach(persons.personList, id:\.id){ person in
                        Text("\(person.name)")
                    }
                }
            }
            .navigationTitle("FaceMapper")
            .toolbar{
                Button{
                    locationFetcher.start()
                    showPickerSheet = true
                }label:{
                    HStack{
                        Image(systemName: "plus")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.trailing,-5)
                        Text("Add")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .onChange(of: showAdditionalInfoSheet){ _ in
                    showAddInfoSheet = true
                }
            }
            .sheet(isPresented: $showPickerSheet){
                ImagePicker(image: $inputImage, addInfo: $showAdditionalInfoSheet)
            }
            .sheet(isPresented: $showAddInfoSheet){
                if let uiImage = inputImage{
                    if let currentLocation = locationFetcher.lastKnownLocation{
                        AddInfoView(persons: persons, currentRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)), image: Image(uiImage: uiImage))
                    }else{
                        AddInfoView(persons: persons, currentRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.504, longitude: -0.11), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)), image: Image(uiImage: uiImage))
                    }

                } else {
                    
                }
            }
        }
//  End of body
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
