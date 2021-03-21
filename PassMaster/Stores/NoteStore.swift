//
//  NoteStore.swift
//  PassMaster
//
//  Created by aleuts on 20/03/2021.
//

import Foundation

class NoteStore : ObservableObject{

    @Published var Notes: [NoteModel]
    
    init() {
        self.Notes = [NoteModel(id: 1, AccountType: AccountType.Note, name: "Card Pins", note: "Visa - 1234"),
                      NoteModel(id: 2, AccountType: AccountType.Note, name: "Todo", note: "Go Gym!"),
                      NoteModel(id: 3, AccountType: AccountType.Note, name: "Call Doctor", note: "Tell him about PAIN")]
    }
    
    func GetNewNoteId() -> Int {
        
        let current: Int = Notes.last?.id ?? 0
        print("Current items:", current)
        return current + 1
    }

    func AddNote(account: NoteModel) -> Void {
        
        var note: NoteModel
        note = account
        note.id = GetNewNoteId()
        note.AccountType = .Note
        
        Notes.append(note)
    }

    func RemoveNote(id: Int) {
        
        let index = Notes.firstIndex(where: {$0.id == id}) ?? 0
        Notes.remove(at: index)
    }

    func EditNote(modified: NoteModel) -> Void {
        let index = Notes.firstIndex(where: {$0.id == modified.id})
        let original: NoteModel = Notes[index ?? 0]
        var temp = modified
        
        if !modified.equals(original) {
            temp.name = modified.name == original.name ? original.name : modified.name
            temp.note = modified.note == original.note ? original.note : modified.note
            Notes[index ?? 0] = temp
        }
    }
     
    func RestoreNote(account: NoteModel) -> Void {
        Notes.append(account)
        Notes = Notes.sorted(by: {( first:NoteModel, second: NoteModel) -> Bool in
            first.id < second.id
        })
    }
}