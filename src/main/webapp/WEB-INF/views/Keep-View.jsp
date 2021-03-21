<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"
	integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w=="
	crossorigin="anonymous"></link>
<title>Keep</title>
</head>
<body>


	<%@ include file="home.jsp"%>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
let data;
$( function() {
    $( "#sortable" ).sortable({
    	update: function (event, ui) {
    	
         data = $(this).sortable('serialize');
		//alert(data);
		var x = document.getElementById("save_changes");
		x.style.display = "inline-block";
        
    }
    });
    $( "#sortable" ).disableSelection();
  } );
  
function saveRanking(){
	if(data){
		$.ajax({
            dataType: 'JSON',
    		data:  JSON.stringify(data),
    		contentType:"application/json; charset=UTF-8",
            type: 'POST',
            url: '/Keep/saveNotesOrder'
        });
	}
}
  
</script>

	<br>

	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h1>All Notes:</h1>
			</div>
			<div class="col-md-2">
				<c:if test="${not empty MaxPriority && MaxPriority !=-1}">
					<div class="dropdown">
						<button class="btn btn-default dropdown-toggle" type="button"
							id="menu1" data-toggle="dropdown">
							<img src="<c:url value='/imgresources/settingsIcon.jpg'/>"
								style="max-width: 30px;"> <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="/Keep/allNoteView?sortingPreference=0">Sort by Natural
									Order</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="/Keep/allNoteView?sortingPreference=1">Sort by
									Priority</a></li>
						</ul>
					</div>
				</c:if>

			</div>
			<div class="col-md-4 text-right">
				<button type="button" class="btn btn-primary" style="display: none;"
					id="save_changes" onclick="saveRanking()">Save Changes</button>
			</div>
		</div>
		<br>
		<!-- Draggable default card start -->
		<!-- Simple List -->
		<div class="card">
			<div class="card-block" id="sortable">
				<c:forEach items="${allNotes}" var="todo">
					<div id="note_${todo.id}" class="card-sub mb-3">
						<c:if test="${todo.done}">
							<i class="fas fa-check-double" style="font-size: 1.5rem;"></i>
						</c:if>
						<div class="text-center">
							<img src="<c:url value='/imgresources/note.jpg'/>"
								style="max-width: 100px;" class="card-img-top" alt="...">
						</div>
						<div class="card-body">
							<h5 class="card-title">${todo.title}</h5>
							<p class="card-text">${todo.description}</p>
							<div class="text-center">
								<a href="/Keep/deleteNote?id=${todo.id}" class="btn btn-danger">Delete</a>
								<a href="/Keep/update?id=${todo.id}" class="btn btn-secondary">Update</a>
							</div>
						</div>
					</div>

				</c:forEach>

			</div>
		</div>
		<!-- Draggable default card start -->

	</div>

</body>
</html>