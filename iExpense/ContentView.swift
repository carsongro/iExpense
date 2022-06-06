//
//  ContentView.swift
//  iExpense
//
//  Created by Carson Gross on 6/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var expenseType = "Personal"
    @State private var showingPersonal = true
    
    let types = ["Personal", "Business"]

    
    var dollarFormat: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    var body: some View {
        NavigationView {
            List {
                Picker("Input Unit", selection: $expenseType) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                
                ForEach(expenses.items) { item in
                    if item.type == expenseType {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            if item.amount < 10 {
                                Text(item.amount, format: dollarFormat)
                            } else if item.amount < 100 {
                                Text(item.amount, format: dollarFormat)
                                    .font(.headline)
                            } else {
                                Text(item.amount, format: dollarFormat)
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                            
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
