//
//  ContentView.swift
//  DayCounter
//
//  Created by karaba on 12/8/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: DayCounterViewModel

    init(viewModel: DayCounterViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Contador grande
                VStack(spacing: 8) {
                    Text(viewModel.title.isEmpty ? "Contador de días" : viewModel.title)
                        .font(.title2).fontWeight(.semibold)
                        .multilineTextAlignment(.center)

                    Text("\(viewModel.days)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .contentTransition(.numericText())
                        .monospacedDigit()

                    Text(viewModel.subtitle)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 16)

                // Configuración
                Form {
                    Section("Modo") {
                        Picker("Modo", selection: $viewModel.mode) {
                            Text("Hasta una fecha").tag(DayCounter.Mode.until)
                            Text("Desde un evento").tag(DayCounter.Mode.since)
                        }
                        .pickerStyle(.segmented)

                        Toggle("Contar día final/inicial (inclusive)", isOn: $viewModel.inclusive)
                    }

                    Section("Detalles") {
                        TextField("Título", text: $viewModel.title)
                            .textInputAutocapitalization(.sentences)
                    }

                    if viewModel.mode == .until {
                        Section("Fecha objetivo") {
                            DatePicker("Objetivo", selection: $viewModel.endDate, displayedComponents: .date)
                        }
                    } else {
                        Section("Evento ocurrido") {
                            DatePicker("Inicio", selection: $viewModel.startDate, displayedComponents: .date)
                        }
                    }

                    Section {
                        Button {
                            viewModel.persist()
                        } label: {
                            Label("Guardar", systemImage: "tray.and.arrow.down")
                        }
                    }
                }
            }
            .navigationTitle("Contador de días")
        }
    }
}

#Preview {
    ContentView(viewModel: .init())
}
