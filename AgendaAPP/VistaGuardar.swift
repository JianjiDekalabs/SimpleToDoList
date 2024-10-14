//  VistaGuardar.swift
//  AgendaAPP
//  Created by Jianji Zhong Huang on 11/10/24.

import SwiftUI

struct VistaGuardar: View {
    @State var terea: String = ""
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Form {
                Section(header: Text("Introduce la terea")) {
                    TextField("Terea", text: $terea)
                }
                
                HStack {
                    Rectangle()
                        .frame(maxWidth: 90, maxHeight: .infinity)
                        .opacity(0)
                    Button(action: {

                        do {
                            // Aquí manejamos el posible error
                            try viewModel.saveAgendas(viewModel.addAgenda(terea))
                            isPresented.toggle()
                        } catch {
                            // Manejo del error (puedes mostrar un alerta, etc.)
                            print("Error al guardar agendas: \(error)")
                        }
                    }, label: {
                        Text("Guardar")
                    })
                }
            }.frame(maxWidth: 350, maxHeight: 300)
                .cornerRadius(10)
            
            Spacer()
            
        }.onAppear {
            print(viewModel.agendas)
        }
    }
}

