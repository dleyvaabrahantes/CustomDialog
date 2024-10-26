// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

@available(iOS 16.0.0, *)
struct RectangleWithCurvedTopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius : CGFloat = 30
        
        //Top left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        let midx = rect.width / 2
        let width = rect.width
        let yOffset: CGFloat = 50
        let controlWidth = midx - 50
        let to = CGPoint(x: midx, y: rect.minY - yOffset)
        let control1 = CGPoint(x: controlWidth, y: rect.minY)
        let control2 = CGPoint(x: controlWidth, y: rect.minY-yOffset)
        
        let to1 = CGPoint(x: width, y: rect.minY)
        let control3 = CGPoint(x: width-controlWidth, y: rect.minY-yOffset)
        let control4 = CGPoint(x: width-controlWidth, y: rect.minY)
        
        path.addCurve(to: to, control1: control1, control2: control2)
        path.addCurve(to: to1, control1: control3, control2: control4)
        
        
        
        //Top Line with rounder corner
        path.addLine(to: CGPoint(x: rect.maxX-cornerRadius, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY+cornerRadius), control: CGPoint(x: rect.maxX, y: rect.minY))
        
        //Right line with rounded corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY-cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.maxY))
        
        //Bottom Line
        path.addLine(to: CGPoint(x: rect.minX+cornerRadius, y: rect.maxY))
        
        //Left Line with rounder corner
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY-cornerRadius), control: CGPoint(x: rect.minX, y: rect.maxY))
       
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
    
        
        return path
    }
    
    
}

@available(iOS 16.0.0, *)
public struct ReactangleWithCurvedTopView: View {
    @State private var topOffset:CGFloat = -500
    @State private var bottomOffset:CGFloat = 500
    @State var nameImage: String
    @State var nameColor: Color
    @State var title: String
    @State var subtitle: String
    var actionNo: () -> Void
    var actionYes: () -> Void
    
    public init(nameImage: String, nameColor: Color, title: String, subtitle: String, actionNo: @escaping () -> Void, actionYes: @escaping () -> Void) {
        self.nameImage = nameImage
        self.nameColor = nameColor
        self.title = title
        self.subtitle = subtitle
        self.actionNo = actionNo
        self.actionYes = actionYes
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            ZStack {
                RectangleWithCurvedTopShape()
                    .fill(.white)
                    .frame(width: 350, height: 300)
                    .shadow(radius: 5)
                Image(nameImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .offset(y: topOffset)
                    .onAppear{
                        withAnimation(.easeInOut(duration: 1)){
                            topOffset = -150
                        }
                    }
                VStack{
                    Text(title)
                        .foregroundStyle(nameColor)
                        .font(.system(size: 20, design: .serif))
                        .bold()
                    VStack{
                        Text(subtitle)
                            .foregroundStyle(.black)
                            .font(.system(size: 18, design: .serif))
                            .bold()
                        
                        HStack{
                            Button(action: actionNo, label: {
                                Text("No")
                                    .foregroundStyle(nameColor)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(nameColor,lineWidth:2)
                                    }
                            })
                            
                            Button(action: actionYes, label: {
                                Text("Yes")
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(nameColor)
                                           
                                    }
                            })
                        }
                    }
                }
                .frame(width: 300)
                .offset(y: CGFloat(bottomOffset))
                .onAppear{
                    withAnimation(.easeInOut(duration: 1)){
                        bottomOffset = 40
                    }
                }
            }
        }
    }
}

@available(iOS 16.0.0, *)
#Preview {
    ReactangleWithCurvedTopView(nameImage: "user1", nameColor: .green, title: "Wait!", subtitle: "Do you really want to quit? You will lose your progress!",actionNo: {}, actionYes: {})
}
