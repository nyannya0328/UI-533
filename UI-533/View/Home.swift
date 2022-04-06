//
//  Home.swift
//  UI-533
//
//  Created by nyannyan0328 on 2022/04/06.
//

import SwiftUI

struct Home: View {
    @State var currentTab : Int = 0
    @State var currentTitle : String = "Flilms"
    @Environment(\.colorScheme) var scheme
    @Namespace var animation
    
    @State var showDetail : Bool = false
    @State var currentItem : Movie?
    @State var currentSize : CGSize = .zero
    var body: some View {
        ZStack{
            
            BGView()
            
            VStack{
              navBar()
                
                
                SnapCarousel(index: $currentTab, items: movies) { movie in
                    
                    
                    GeometryReader{proxy in
                        
                        let size = proxy.size
                        
                        Image(movie.artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                            .onTapGesture {
                                
                                currentItem = movie
                                currentSize = size
                                
                                withAnimation(.easeInOut){
                                    
                                    showDetail = true
                                }
                            }
                    }
                    
                }
                .padding(.top,70)
                
                
                CustomIndicator()
                
                
                HStack{
                    
                    Text("Popular")
                        .font(.title3.bold())
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        
                        Text("See More")
                    }

                        
                }
                .padding(.horizontal)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    HStack(spacing:20){
                        
                        
                        ForEach(movies){mov in
                            
                            Image(mov.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 160)
                                .cornerRadius(15)
                              
                        }
                        
                        
                        
                    }
                }
                .padding([.horizontal,.bottom])
            }
        }
        .overlay {
            
            if let currentItem = currentItem,showDetail {
                
                
                DetailView(movie: currentItem, currentSize: $currentSize, detailMovie: $currentItem, showDetail: $showDetail,animation: animation)
            }
        }
    }
    @ViewBuilder
    func CustomIndicator()->some View{
        
        HStack(spacing:13){
            
            ForEach(movies.indices,id:\.self){index in
                
                Circle()
                    .fill(currentTab == index ? .orange : .gray)
                    .frame(width: currentTab == index ? 20 : 6, height: currentTab == index ? 20 : 6)
                    .animation(.easeInOut(duration: 0.5), value: currentTab)
                
            }
        }
        
        
    }
    @ViewBuilder
    func navBar()->some View{
        
        
        HStack(spacing:10){
            
            
            ForEach(["Flilms","Locality"],id:\.self){title in
                
                Button {
                    
                    withAnimation{
                        currentTitle = title
                    }
                    
                } label: {
                    
                    
                    Text(title)
                        .font(.title3)
                        .foregroundColor(currentTitle == title ? .white : .gray)
                        .padding(.vertical,10)
                        .padding(.horizontal,15)
                        .background{
                            
                           
                                
                                if currentTitle == title{
                                    
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme,.dark)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                    
                                }
                            
                        }
                }

            }
        }
        .padding(.top,20)
        
    }
    
    @ViewBuilder
    func BGView()->some View{
        
        GeometryReader{proxy in
            
            let size = proxy.size
            
            TabView(selection: $currentTab) {
                
                
                ForEach(movies.indices,id:\.self){index in
                    
                    
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                    
                }
                .ignoresSafeArea()
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentTab)
            
            let color : Color = (scheme == .dark ? .black : .white)
            
            LinearGradient(colors: [
            
                .black,
                .clear,
                color.opacity(0.5),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            
            
            
            
            ], startPoint: .top, endPoint: .bottom)
            
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
        
        
    }
    
   
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

