//
//  ContentView.swift
//  Apitest
//
//  Created by pc on 20/04/25.
//

import SwiftUI



struct Quote: Codable{
    var author:String
    var quote:String
}

struct ContentView: View {
    @State private var quotes = [Quote]()
        
    var body: some View {
        NavigationView{
            List(quotes, id: \.quote) { quote in
                VStack(alignment: .leading)
                {
                    Text(quote.author)
                        .font(.headline)
                    Text(quote.quote)
                        .font(.body)
                        
                }
                }.navigationTitle("Quotes")
                .task{
                    await fetchdata()
                }
            }
        }
    
    func fetchdata() async{
        //Create URL
        guard let url = URL(string: "https://api.breakingbadquotes.xyz/v1/quotes/10") else {
            print("Hey man this data is not working")
            return
        }
        
        //fetch data from that URL
        do{
            let(data,_) = try await URLSession.shared.data(from: url)
            
            
            //decode
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data){
                self.quotes = decodedResponse
            }
        }
            
            catch{
                print("I am unable to fetch data")
                
            }
        
        
        //decode that data
        
        
        
    }
    
    
    
    
    
    
    }




#Preview {
    ContentView()
}
