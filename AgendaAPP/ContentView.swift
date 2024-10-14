import SwiftUI

struct ContentView: View {
    @State var addView: Bool = false
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if !addView {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 0)
                    Text("Simpe to do List")
                        .font(.title)
                    
                    List {
                        ForEach(viewModel.agendas) { index in
                            Text(index.description)
                        }.onDelete { indexSet in
                            indexSet.forEach { index in
                                do{
                                    try viewModel.saveAgendas(viewModel.removeAgenda(viewModel.agendas[index]))
                                } catch {
                                    // Manejo del error (puedes mostrar un alerta, etc.)
                                    print("Error al guardar agendas: \(error)")
                                }
                            }
                        }
                        
                    }
                    .ignoresSafeArea()
                }
                
                BottonPart(addView: $addView)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .opacity(0)

            }
            if addView {
                VistaGuardar(isPresented: $addView, viewModel: viewModel)
            }
        }.onAppear {
            viewModel.loadAgendas()
            print(viewModel.agendas)
            
        }
    }
    
}

struct BottonPart: View {
    @Binding var addView: Bool
    var body: some View {
        HStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 0)
            Button(action: {
                addView.toggle()
            }, label: {
                Image(systemName: "plus")
            }).frame(maxWidth: 55, maxHeight: 55)
            .background(.green)
            .cornerRadius(20)
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    ContentView()
}
