//
//  ListView.swift
//  ToDoMidterm
//
//  Created by Quinn Brittain on 3/20/22.
//

import SwiftUI

struct ListView: View {

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

    private func updateTask(_ task: Task) {
        task.isComplete.toggle()
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task)

            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
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
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(task.isComplete ? .green: .none)
                        }
                        .onTapGesture {
                            updateTask(task)
                        }
                    }.onDelete(perform: deleteTask)
                }

                Spacer()
            }
            .navigationTitle("Todo List")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
