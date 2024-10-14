//  ViewModel.swift
//  AgendaAPP
//  Created by Jianji Zhong Huang on 11/10/24.

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var agendas: [Agenda] = []
    
    func addAgenda(_ agenda: String) -> [Agenda] {
        agendas.append(Agenda(description: agenda))
        return agendas
    }
    
    func removeAgenda(_ agenda: Agenda) -> [Agenda]{
        agendas.removeAll(where: { $0.description == agenda.description })
        return agendas
    }

    /**
     Persistencia de datos
     Pasos básicos:
     1. Obtener la ruta del directorio de documentos de la aplicación.
     2. Codificar los datos en un formato que puedas almacenar en un archivo (JSON, por ejemplo).
     3. Guardar los datos en un archivo.
     4. Leer los datos desde el archivo cuando se necesiten.
     5. Decodificar los datos del archivo para utilizarlos nuevamente en la app.
     */
    //1. Obtener la ruta del directorio de documentos de la aplicación
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    /*FileManager es una clase del sistema para trabajar con archivos y directorios.
     La función urls(for:in:) devuelve una lista de rutas, y el primer elemento (paths[0]) es la ruta que necesitas para el directorio de documentos*/
    
    
    //2. Codificar los datos en un formato adecuado (JSON)
    func saveAgendas(_ agendas: [Agenda]) throws{
        do {
            let data = try JSONEncoder().encode(agendas)  // Codificar la lista a JSON
            saveToFile(data: data, filename: "agendas.json")  // Guardar los datos
        } catch {
            print("Error al codificar las agendas: \(error)")
        }
    }
    
    //3. Guardar los datos en un archivo
    func saveToFile(data: Data, filename: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            print("Datos guardados exitosamente.")
        } catch {
            print("Error al guardar los datos: \(error)")
        }
    }
    
    //4. Leer los datos desde el archivo
    func loadFromFile(filename: String) -> Data? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print("Error al cargar los datos: \(error)")
            return nil
        }
    }
    
    //5. Decodificar los datos del archivo para utilizarlos nuevamente en la app.
    func loadAgendas() {
        if let data = loadFromFile(filename: "agendas.json") {
            let decoder = JSONDecoder()
            do {
                // Decodifica los datos en un array de Agenda
                self.agendas = try decoder.decode([Agenda].self, from: data)
            } catch {
                print("Error al decodificar las agendas: \(error)")
            }
        } else {
            print("No se pudieron cargar las agendas desde el archivo.")
        }
    }
}
