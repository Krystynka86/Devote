//
//  ContentView.swift
//  Devote
//
//  Created by Cristina on 2023-07-27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    
    @State var task: String = ""
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTION
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(spacing: 16) {
                      TextField("New Task", text: $task)
                            .padding()
                            .background(
                                Color(UIColor.systemGray6)
                            )
                            .cornerRadius(10)
                        
                    Button(action: {
                        addItem()
                    }, label: {
                        Spacer()
                        Text("SAVE")
                        Spacer()
                    })
                    .disabled(isButtonDisabled)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(isButtonDisabled ? Color.gray : Color.pink)
                    .cornerRadius(10)
                    } //: VSTACK
                    .padding()
                    
                    List {
                        ForEach(items) { item in
                    
                                VStack(alignment: .leading) {
                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                } //: LIST ITEM
                        }
                        .onDelete(perform: deleteItems)
                    } //: LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640) // for iPads
                } //: VSTACK
            } //: ZSTACK
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear // removes the default background color - not working in iOS 16
            }
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                  }
            } //: TOOLBAR
            .background(
            backgroundGradient.ignoresSafeArea()
            )
            } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle()) // support for Ipads, shows only one column at a time
        }
     }


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
