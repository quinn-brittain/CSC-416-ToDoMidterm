//
//  ContentView.swift
//  ToDoMidterm
//
//  Created by Quinn Brittain on 3/20/22.
//

import SwiftUI

struct ContentView: View {

    @State private var title: String = ""
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Task.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "dateCreated",
                                                    ascending: false)])
    private var allTasks: FetchedResults<Task>

    private func saveTask() {
        do {
            let task = Task(context: viewContext)
            task.title = title
            task.dateCreated = Date()
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateTask(_ task: Task) {
        task.isComplete.toggle()
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new task", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading)

                    Button {
                        saveTask()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding(9)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.trailing)
                }

                List {
                    ForEach(allTasks) { task in
                        HStack {
                            Text(task.title ?? "")
                            Spacer()
                            Image(systemName: task.isComplete ? "checkmark.circle.fill": "circle")
                                .onTapGesture {
                                    updateTask(task)
                                }
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Todo List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
