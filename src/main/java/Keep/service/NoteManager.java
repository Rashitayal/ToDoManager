package Keep.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Keep.entities.Note;
import Keep.repository.NoteRepository;

@Service
public class NoteManager {
	
	@Autowired
	private NoteRepository noteRepository;
	
	public void addNote(Note note) {
		noteRepository.addNote(note);
	}

	public List<Note> allNotes(){
		return noteRepository.allNotes();
	}
	
	public Note getNoteById(int id) {
		return noteRepository.getNoteById(id);
	}
	
	public void deleteNoteById(Note note) {
		noteRepository.deleteNoteById(note);
	}
	
	public Integer getMaxPriority() {
		return noteRepository.getMaxPriority();
	}
	
	public void updateNotePriority(int priority, int noteId) {
		noteRepository.updateNotePriority(priority, noteId);
	}
	
	public List<Note> allNotesSortedByPriority(){
		return noteRepository.allNotesSortedByPriority();
	}
	
	public void updateNote(Note note) {
		noteRepository.updateNote(note);
	}
	
}
