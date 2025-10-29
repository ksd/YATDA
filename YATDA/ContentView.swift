// ContentView.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.06.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI

struct ContentView: View {
    @State private var reminders = Reminder.samples
    @State private var isAddReminderDialogPresented = false
    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }
    var body: some View {
        List($reminders) { $reminder in
            HStack {
                Image(systemName: reminder.isCompleted
                      ? "largecircle.fill.circle"
                      : "circle")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .onTapGesture {
                    reminder.isCompleted.toggle()
                }
                Text(reminder.title)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: presentAddReminderView) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .sheet(isPresented: $isAddReminderDialogPresented) {
            AddReminderView { reminder in
                reminders.append(reminder)
            }
        }
    }
}

#Preview {
    ContentView()
}
