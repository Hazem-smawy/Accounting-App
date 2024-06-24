// Your gridview
import SwiftUI


struct GridView: View {
   var text: String

   var body: some View {
       Text(text)
           .font(.largeTitle)
           .foregroundColor(.white)
           .padding(.vertical, 20)
           .padding(.horizontal, 100)
           .background(.blue)
           .clipShape(Capsule())

   }

   static func fetchItems() -> [String] {
       var arr = [String]()
       for num in 1...15 {
           arr.append("View \(num)")
       }
       return arr
   }
}

struct ContentViewTow: View {
   @State private var items = GridView.fetchItems()

   var body: some View {
       NavigationStack {
           // I have chosen to have 10 views per page
           ShareLink("Export PDF", item: render(viewsPerPage: 10))
           ScrollView {
               LazyVGrid(columns: [GridItem()]) {
                   ForEach(items, id: \.self) { item in
                       GridView(text: item)
                   }
               }
           }
           .navigationTitle("Grid view")
       }

   }

   @MainActor func render(viewsPerPage: Int) -> URL {
       // Save it to our documents directory
       let url = URL.documentsDirectory.appending(path: "output.pdf")

       // Tell SwiftUI our PDF should be of certain size
       var box = CGRect(x: 0, y: 0, width: 600, height: 1200)

       // Create the CGContext for our PDF pages
       guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
           return url
       }

       // Calculate number of pages based on passed amount of viewsPerPage
       // you would like to have
       let numberOfPages = items.count / viewsPerPage

       var index = 0
       for _ in 0..<numberOfPages {

           // Start a new PDF page
           pdf.beginPDFPage(nil)

           // Render necessary views
           for num in 0..<viewsPerPage {
               let renderer = ImageRenderer(content: GridView(text: items[index]))
               renderer.render { size, context in

                   // Will place the view in the middle of pdf on x-axis
                   let xTranslation = box.size.width / 2 - size.width / 2

                   // Spacing between the views on y-axis
                   let spacing: CGFloat = 20

                   // TODO: - View starts printing from bottom, need to inverse Y position
                   pdf.translateBy(
                       x: xTranslation - min(max(CGFloat(num) * xTranslation, 0), xTranslation),
                       y: size.height + spacing
                   )

                   // Render the SwiftUI view data onto the page
                   context(pdf)
                   // End the page and close the file
               }
               index += 1

           }
           pdf.endPDFPage()
       }
       pdf.closePDF()
       return url
       }
}
