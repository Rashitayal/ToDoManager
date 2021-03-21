package Keep.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import Keep.entities.Note;
import Keep.service.NoteManager;

@Controller
public class NoteController {
	
	@Autowired
	private NoteManager noteManager;
	
	@PostMapping("/processAddNote")
	public String processAddNote(@ModelAttribute("note") Note note, HttpServletRequest request) {
		Integer maxPriority = noteManager.getMaxPriority();
		if(maxPriority!=null && maxPriority!=-1) {
			note.setPriority(maxPriority+1);
		}
		note.setCreatedDate(new Date());
		noteManager.addNote(note);
		request.getSession().setAttribute("successMessage","successfully added your note");
		return "Keep-Add";
	}
	
	@GetMapping("/allNoteView")
	public String allNoteView(Model model, @RequestParam(value="sortingPreference", defaultValue = "0") int sortingPreference) {
		if(sortingPreference == 0)
			model.addAttribute("allNotes", noteManager.allNotes());
		else
			model.addAttribute("allNotes", noteManager.allNotesSortedByPriority());
		Integer maxPriority = noteManager.getMaxPriority();
		if(maxPriority!=null);
		model.addAttribute("MaxPriority", maxPriority);
		return "Keep-View";
	}
	
	@GetMapping("/deleteNote")
	public String deleteNoteById(@RequestParam("id") int id, Model model) {
		noteManager.deleteNoteById(noteManager.getNoteById(id));
		model.addAttribute("allNotes", noteManager.allNotes());
		return "Keep-View";
	}
	
	@PostMapping("/saveNotesOrder")
	public void saveNotesOrder(@RequestBody String noteOrder) {
		int priority=0;
		int index1 = noteOrder.indexOf('=');
		int index2 = 0;
		while (index1 >0 ) {
			index2 = noteOrder.indexOf('&', index1+1);
			if(index2<0) {
				noteManager.updateNotePriority(priority, Integer.parseInt(noteOrder.subSequence(index1+1, noteOrder.length()-1).toString()));
				break;
			} 
			noteManager.updateNotePriority(priority,Integer.parseInt(noteOrder.subSequence(index1+1, index2).toString()));

			index1 = noteOrder.indexOf('=', index2+1);
			priority++;
			
		}
	}
	
	@GetMapping("/update")
	public String updateNoteView(@RequestParam("id") int noteId, Model model) {
		model.addAttribute("noteObject",noteManager.getNoteById(noteId));
		return "Keep-Update";
	}
	
	@PostMapping("/processUpdateNote")
	public String processUpdateNote(@ModelAttribute("note") Note note, HttpServletRequest request, Model model) {
		System.out.println("dsdadawd");
		Note persistedNote = noteManager.getNoteById(note.getId());
		if(persistedNote!=null) {
			persistedNote.setDescription(note.getDescription());
			persistedNote.setTitle(note.getTitle());
			persistedNote.setDone(note.isDone());
			noteManager.updateNote(persistedNote);
			request.getSession().setAttribute("successMessage","successfully updated your note");
			model.addAttribute("noteObject",persistedNote);
			return "Keep-Update";
		} else {
			return "error";
		}
	}

}
