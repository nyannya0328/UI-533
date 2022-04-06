//
//  DetailView.swift
//  UI-533
//
//  Created by nyannyan0328 on 2022/04/06.
//

import SwiftUI

struct DetailView: View {
    var movie : Movie
    @Binding var currentSize : CGSize
    @Binding var detailMovie : Movie?
    @Binding var showDetail : Bool
    var animation : Namespace.ID
    
    @State var showDetailContent : Bool = false
    
    @State var offSet : CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:15){
                
                Image(movie.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentSize.width, height: currentSize.height)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: movie.id, in: animation)
                
                
                VStack(spacing:20){
                    
                    
                    Text("Story Plot")
                        .font(.title.weight(.black))
                        .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    Text(sampleText)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                    
                    
                    Button {
                        
                    } label: {
                        
                        Text("Book Ticket")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical,15)
                            .frame(maxWidth:.infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                   

                    
                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y:showDetailContent ? 0 : 250)
                .padding(.top,20)
               
                
                
                
            }
            .padding()
            .modifier(OffsetModifier(offset: $offSet))
            
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(
        
        Rectangle()
            .fill(.ultraThinMaterial).ignoresSafeArea()
        
        )
        .onAppear(perform: {
            withAnimation{
                
                showDetailContent = true
            }
        })
        
        .onChange(of: offSet) { newValue in
            
            if newValue > 120{
                
                withAnimation(.easeInOut){
                    
                    showDetailContent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    
                    withAnimation(.easeInOut){
                        
                        showDetail = false
                    }
                    
                    
                    
                }
                
            }
            
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
