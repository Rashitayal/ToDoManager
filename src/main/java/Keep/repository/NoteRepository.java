package Keep.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import Keep.entities.Note;

@Repository
public class NoteRepository {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	
	@Transactional
	public void addNote(Note note) {
		hibernateTemplate.save(note);
	}
	
	public List<Note> allNotes(){
		Session session = hibernateTemplate.getSessionFactory().openSession();
		Criteria criteria = session.createCriteria(Note.class, "note");
		return (List<Note>) criteria.addOrder(Order.asc("id")).list();
	}
	
	public List<Note> allNotesSortedByPriority(){
		Session session = hibernateTemplate.getSessionFactory().openSession();
		Criteria criteria = session.createCriteria(Note.class, "note");
		return (List<Note>) criteria.addOrder(Order.asc("priority")).list();
	}

	@Transactional
	public void deleteNoteById(Note note) {
		hibernateTemplate.delete(note);
	}
	
	public Note getNoteById(int id) {
		return hibernateTemplate.get(Note.class, id);
	}
	
	public Integer getMaxPriority() {
		return (Integer)hibernateTemplate.getSessionFactory().openSession().createSQLQuery("SELECT max(priority) from note").getSingleResult();
	}
	
	public void updateNotePriority(int priority, int noteId) {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		session.createSQLQuery("UPDATE note set priority =:priority where note_id =:id")
		.setInteger("priority", priority).setInteger("id", noteId).executeUpdate();
		transaction.commit();
	}
	
	@Transactional
	public void updateNote(Note note) {
		hibernateTemplate.merge(note);
	}
	
}
