//
//  PetDetailsView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 11.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

// Clean me please
// Clean me please
// Clean me please
// Clean me please
// Clean me please
// Clean me please
// Clean me please
// Clean me please


import SwiftUI
import Charts

struct Bar : UIViewRepresentable {
    var entries : [BarChartDataEntry]
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()
        chart.pinchZoomEnabled = false;
        chart.doubleTapToZoomEnabled = false;
        return chart
    }
    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.data = addData()
    }
    func addData() -> BarChartData{
        let data = BarChartData()
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.colors = [NSUIColor.green]
        //dataSet.label = "Days";
        //dataSet.stackLabels = ["monday","a","b","c","d","e","f"]
        data.addDataSet(dataSet)
        return data
    }
    typealias UIViewType = BarChartView
}

struct PetDetailsView: View {
    
    @EnvironmentObject var modelData : ModelData
    var pet: Pet
    
    func feedingDataOfPast7Days() -> [BarChartDataEntry]{
        
        var weeklyCalorieData : [Int] = [0,0,0,0,0,0,0]
        var barData : [BarChartDataEntry] = []
        
        let feedingData : [Feeding] = modelData.feedings;
        
        for feeding in feedingData {
            if feeding.petId != pet.id{
                continue
            }
            guard let date : Date = getDate(dateStr: feeding.dateString) else {
                continue
            }
            if (isDayInCurrentWeek(date: date) ?? false){
                print( "this feeding data lays in current week " + feeding.json())
                let calendar = Calendar.current
                guard let weekday = calendar.dateComponents([.weekday], from: date).weekday else{
                    print("something bad happened while weekday convertion process")
                    continue
                }
                guard let feed = getFeedWithId(feedId: feeding.feedId) else {
                    print("broken feed data. feed cannot be found")
                    continue
                }
                weeklyCalorieData[weekday-1] += feeding.amount * feed.calorie;
            }
        }
        
        var i = 1
        for data in weeklyCalorieData{
            barData.append(BarChartDataEntry(x: Double(i), y: Double(data)))
            i += 1
        }
        
        return barData
    }
    
    func getFeedWithId(feedId : Int) -> Feed? {
        for feed in modelData.feeds{
            if feed.id == feedId{
                return feed
            }
        }
        return nil
    }
    
    func isDayInCurrentWeek(date: Date) -> Bool? {
        let currentComponents = Calendar.current.dateComponents([.weekOfYear], from: Date())
        let dateComponents = Calendar.current.dateComponents([.weekOfYear], from: date)
        guard let currentWeekOfYear = currentComponents.weekOfYear, let dateWeekOfYear = dateComponents.weekOfYear else { return nil }
        return currentWeekOfYear == dateWeekOfYear
    }
    
    func getDate(dateStr : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let createdDate = dateFormatter.date(from: dateStr)
        return createdDate
    }
        
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Bar(entries: feedingDataOfPast7Days())
            
            FeedingListView(pet: pet).environmentObject(modelData)
            
            Spacer()
            
            NavigationLink(
                destination: FeedFormView().environmentObject(modelData),
                label: {
                    Text("New Feed")
                })
            
            NavigationLink(
                destination: FeedingFormView(pet: pet).environmentObject(modelData),
                label: {
                    Text("Feed your pet")
                })

            Text(pet.json())

        }
        
    }
}

struct PetDetailsView_Previews: PreviewProvider {
    static var pets = ModelData().pets

    static var previews: some View {
        PetDetailsView(pet: pets[0] ).environmentObject(ModelData())
    }
}
