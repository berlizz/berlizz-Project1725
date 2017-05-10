<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="com.berlizz.domain.SecurityUserVO" %>

<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	Object principal = auth.getPrincipal();

	String userId = "";		// 사용자 아이디
	String userName = "";	// 사용자 이름

	if(principal != null && principal instanceof SecurityUserVO) {
		userId = ((SecurityUserVO)principal).getUsername();	// 사용자 아이디
		userName = ((SecurityUserVO)principal).getName();	// 사용자 이름
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>berlizz | List</title>
	
	<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<%-- 댓글 타임라인 css --%>
	<link href="/resources/css/timeline.css" rel="stylesheet" type="text/css" />
	<%-- 업로드 창 css --%>
	<link href="/resources/css/upload.css" rel="stylesheet" type="text/css" />

	<%-- csrf, csrf header ajax통신을 하기 전에 list.js에서 가져다 씀 --%>
	<sec:csrfMetaTags/> 
	
</head>



<body>
	
	<div style="height:100px; width:100%; font-size:50px; text-align:center; background-color:#337ab7;">
		<a href="/" style="decoration:none; color:white;">Personal Project</a>
	</div>
	
	
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"></a>
			</div>
			
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">List <span class="sr-only">(current)</span></a></li>
					<li><a href="/board/calendar">Calendar</a></li>
					<li><a href="/board/archive">Archive</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> <%=userName%><span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<!-- <li class="divider"></li> -->
							<li><a href="javascript:signOut()" id="signOutBtn">Sign out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	<%-- 사용자 이름, 아이디 저장 --%>
	<input type="hidden" id="userId" value="<%=userId%>">
	<input type="hidden" id="userName" value="<%=userName%>">
	<%-- <input type="hidden" id="userId" value="${signIn.userId}"> --%>
	<%-- <input type="hidden" id="userName" value="${signIn.userName}"> --%>
	
	
	<div class="col-md-3 col-xs-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Reversed List</h3>
			</div>
			
			<div class="panel-body">
				<div class="list-group">
				</div>
			</div>
			
		</div>
	</div>

	<div class="col-md-3 col-xs-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Uncompleted List</h3>
			</div>
			
			<div class="panel-body">
				<div class="list-group">
					<div class="uncompletedList">
					</div>
				</div>
			</div>
			
		</div>
	</div>

	<div class="col-md-3 col-xs-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Added List</h3>
			</div>
			
			<div class="panel-body">
				<div class="list-group">
					<div class="totalList">				
					</div>			
				</div>
				
				<button type="button" class="btn btn-default showInputBtn">ADD 
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
				
				<div class="listInput" style="display:none;">
					<input type="text" id="title">
					<button type="button" class="btn btn-default" id="listAddBtn">ADD</button>
					<button type="button" class="btn btn-default hideInputBtn">
						<span class="glyphicon glyphicon-remove"></span></button>
				</div>
			</div>
			
		</div>
			
	</div>
	
	<div class="col-md-3 col-xs-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Completed List</h3>
			</div>
			
			<div class="panel-body">
				<div class="list-group">
					<div class="completedList">
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	
	<%-- uncompleted list modal --%>
	<div class="modal" id="uncompletedModal" tabindex="-1" role="dialog" aria-labelledby="uncompletedModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="form-inline">
					<div class="modal-header" data-ln="">
						<div class="form-gorup">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="form-group">
							<h3 class="modal-title" id="uncompletedModalLabel">uncompleted list modal title</h3>
						</div>
						<div class="form-group">
							<span class="regTimestamp">regTimestamp</span>
						</div>
					</div>
				</div>
				
				<div class="modal-body">
					
					<h4>Description 
						<button type="button" class="btn btn-default btn-xs descriptionEdit">Edit</button>
						<button type="button" class="btn btn-default pull-right" data-toggle="modal" data-target="#attachmentModal">
							<span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span> Attachment</button>
					</h4>
						
					
					<p class="description"></p>
				
					<div class="EditWindow" style="display:none">
						<textarea name="description" id="editText" rows="10" style="resize:none; width:100%;">description</textarea>
						<button type="button" class="btn btn-primary btn-xs editBtn">Save</button>
						<button type="button" class="btn btn-default btn-xs cancelBtn">Cancel</button>
					</div>


					<div class="row attachList">
					</div>
					
					<div class="replyInput">
						<label><span class="glyphicon glyphicon-comment" aria-hidden="true"></span> Reply</label><br>
						<textarea name="replytext" id="replyText" rows="2" style="resize:none; width:90%;"></textarea>
						<button type="button" class="btn btn-primary btn-xs addReplyBtn">Add</button>
					</div>
					
					<div class="replyList">
					</div>
					
				</div>
				
				
				<div class="modal-footer">
					<button type="button" id="completeChkBtn" class="btn btn-primary">Complete</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
				
			</div>
		</div>
	</div>
	
	<%-- complete check modal --%>
	<div class="modal fade bs-example-modal-sm" id="completeChkModal" tabindex="-1" role="dialog" aria-labelledly="completeChkModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					You done?
				</div>
				<div class="modal-footer">
					<button type="button" id="completeBtn" class="btn btn-primary">Yes</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
				</div>
			</div>
		</div>
	</div>
	
	<%-- completed list modal --%>
	<div class="modal" id="completedModal" tabindex="-1" role="dialog" aria-labelledly="completedModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h3 class="modal-title">completed list modal title</h3>
					<span class="regTimestamp"></span>
				</div>
				
				<div class="modal-body">
					<p class="description"></p>
					
					<div class="row attachList">
					</div>
					
					<div class="replyList">
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<%-- file attachment modal --%>
	<div class="modal" id="attachmentModal" tabindex="-1" role="dialog" aria-labelledly="attachmentModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h3 class="modal-title">Attachment Modal</h3>
					<p>Attachment</p>
				</div>
				<div class="modal-body">
					<div style="text-align:center;">
						<label>File Drop Here</label>
						<div class="fileDrop">
						</div>
						
						<div class="row uploadList">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="attachedSubmitBtn" class="btn btn-primary">Submit</button>
				</div>
			</div>
		</div>
	</div>
	

<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<%-- handlebars.js --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.6/handlebars.min.js"></script>



<%-- 당일 등록 리스트 템플릿 --%>
<script id="listTemplate" type="text/x-handlebars-template">
{{#each .}}
	<a data-ln={{listNumber}} class="list-group-item eachList" data-toggle="modal" data-target="#uncompletedModal">
		<h4 class="list-group-item-heading">{{title}}</h4>
		<p class="list-group-item-text">{{editDescription description}}</p>
		<p>
			{{#isAttach attachCount}}
			{{/isAttach}}
			{{#isReply replyCount}}
			{{/isReply}}
		</P>
	</a>
{{/each}}
</script>

<%-- 미완료 리스트 템플릿 --%>
<script id="uncompletedListTemplate" type="text/x-handlebars-template">
{{#each .}}
	<a data-ln={{listNumber}} class="list-group-item uncompletedEachList" data-toggle="modal" data-target="#uncompletedModal">
		<h4 class="list-group-item-heading">{{title}}</h4>
		<p class="list-group-item-text">{{editDescription description}}</p>
		<p>
			{{#isAttach attachCount}}
			{{/isAttach}}
			{{#isReply replyCount}}
			{{/isReply}}
		</P>
	</a>
{{/each}}
</script>
 
<%-- 완료된 리스트 템플릿 --%>
<script id="completedListTemplate" type="text/x-handlebars-template">
{{#each .}}
	<a data-ln={{listNumber}} class="list-group-item completedEachList" data-toggle="modal" data-target="#completedModal">
		<h4 class="list-group-item-heading">{{title}}</h4>
		<p class="list-group-item-text">{{editDescription description}}</p>
		<p>
			{{#isAttach attachCount}}
			{{/isAttach}}
			{{#isReply replyCount}}
			{{/isReply}}
		</P>
	</a>
{{/each}}
</script>

<%-- 첨부파일 리스트 템플릿 --%>
<script id="attachTemplate" type="text/x-handlebars-template">
	<div class="col-sm-6 col-md-4 attachment">
		<div class="thumbnail" data-src="{{fullName}}">
			<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn">X</a><br>
			<img src="{{imgsrc}}" alt="attachment" style="height:100px;">
			<div class="caption">
				<h4><a href="{{getLink}}">{{fileName}}</a></h4>
				<p></p>
			</div>
		</div>
	</div>
</script>

<%-- 업로드 리스트 템플릿 --%>
<script id="uploadTemplate" type="text/x-handlebars-template">
	<div class="col-sm-6 col-md-4 attachment">
		<div class="thumbnail" data-src="{{fullName}}">
			<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn">X</a><br>
			<img src="{{imgsrc}}" alt="attachment" style="height:100px;">
			<div class="caption">
				<h4><a href="{{getLink}}">{{fileName}}</a></h4>
				<p></p>
			</div>
		</div>
	</div>
</script>

<%-- 리플라이 리스트 템플릿 --%>
<script id="replyTemplate" type="text/x-handlebars-template">
{{#each .}}
<div class="message-item" id="{{listNumber}}">
	<div class="message-inner">
		<div class="message-head clearfix">
			<div class="avatar pull-left"><a href="#"><img src="/resources/images/avatar.png"></a></div>
			<div class="user-detail">
				<h5 class="handle">{{replyWriter}}</h5>
				<div class="post-meta">
					<div class="asker-meta">
						<span class="qa-message-what"></span>
						<span class="qa-message-when">
							<span class="qa-message-when-data">{{replyTimeFormat regDate}}</span>
						</span>
						<span class="qa-message-who">
							<span class="qa-message-who-pad">- </span>
							<span class="qa-message-who-data"><a href="javascript:openEditor({{replyNumber}})">edit</a></span>
							<span class="qa-message-who-pad">- </span>
							<span class="qa-message-who-data"><a href="javascript:deleteReply({{replyNumber}}, {{listNumber}})">delete</a></span>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="qa-message-content reply-{{replyNumber}}">
			{{replytext}}
		</div>
	</div>
</div>
{{/each}}
</script>
<%-- list.js --%>
<script src="/resources/js/list.js"></script>
<!-- <script>
	$(document).ready(function() {
		getList();
		getUncompletedList();
		getCompletedList();
	});
</script> -->
<%-- reply.js --%>
<script src="/resources/js/reply.js"></script>
<%-- upload.js --%>
<script src="/resources/js/upload.js"></script>

</body>
</html>





















