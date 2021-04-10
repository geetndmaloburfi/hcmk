<%@page import="hcmk.com.hibernate.DAO.ProductDAO"%>
<%@page import="hcmk.com.hibernate.DAO.CartDetailDAO"%>
<%@page import="hcmk.com.hibernate.DAO.CartDAO"%>
<%@page import="hcmk.com.hibernate.DAO.UsersDAO"%>
<%@page import="hcmk.com.hibernate.entity.Product"%>
<%@page import="hcmk.com.hibernate.entity.Users"%>
<%@page import="hcmk.com.hibernate.entity.Cart"%>
<%@page import="hcmk.com.hibernate.entity.CartDetail"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String username = null, sessionID = null;
String currentLoggedInUser = null;
if (request.getSession().getAttribute("username") == null) {
%>
<jsp:include page="/include/header.jsp" />
<%
} else {
username = request.getSession().getAttribute("username").toString();

sessionID = request.getSession().getId();
%>
<jsp:include page="/include/userheader.jsp" />
<%
}
%>
<div class="container-fluid">
	<div class="row">
		<div class=" bg-black text-white col-12 col-md-3 col-xl-2 bd-sidebar"
			style="background-color: black;">
			<div class=" mt-3 mb-3">
				<h5 class="text-muted">User Dashboard</h5>
				<%
				int getlink = 0;
				%>
				<ul class="nav nav-tabs flex-column">
					<li class="nav-item"><a class="nav-link text-white"
						onclick="<%getlink = 1;%>"
						href="<%=request.getContextPath()%>/Dashboard?getlink=1">VIEW
							ORDERS</a></li>
					<li class="nav-item active"><a class="nav-link text-white"
						onclick="<%getlink = 2;%>"
						href="<%=request.getContextPath()%>/Dashboard?getlink=2">VIEW
							CART</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						onclick="<%getlink = 4;%>"
						href="<%=request.getContextPath()%>/Dashboard?getlink=3">MANAGE
							ADDRESS</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						onclick="<%getlink = 6;%>"
						href="<%=request.getContextPath()%>/Dashboard?getlink=4"></a></li>
					<li class="nav-item"><a class="nav-link text-white"
						onclick="<%getlink = 7;%>"
						href="<%=request.getContextPath()%>/Dashboard?getlink=5">VIEW
							ORDERS</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						onclick="<%getlink = 8;%>"
						href="<%=request.getContextPath()%>/Logout">Log Out</a></li>

				</ul>
			</div>
		</div>
		<div class="col-9 bg-light">
			<h1 class="center mt-3">Cart Items</h1>
			<%
			Users buyer = UsersDAO.getUserByUserName(username);
			Cart mycart = CartDAO.getCartByUser(username, false);

			List<Product> products = CartDetailDAO.getProductByUser(mycart.getCartId());
			List<Product> productcat = new ArrayList<Product>();
			if (products == null) {
				out.print(
				"<p class=\"text-center\"> Look's Like Someone is not able to decide what to buy</p > <br> <p class=\"text-center\">Your Cart is empty</p>");
			} else {
				for (Product pro : products) {
					productcat.add(pro);
				}
			}
			%>

			<c:forEach items="<%=productcat%>" var="product">
				<div class="card">
					<div class="container-fluid">
						<div class="row">
							<div class="col-sm-3 col-md-6 col-lg-4 col-xl-2">
								<hr>
								<img class="card-img mt-3 mb-3" src="${product.photos }"
									style="width: 100%" alt="Card image">
								<hr>

							</div>
							<div class="col-sm-9 col-md-6 col-lg-8 col-xl-10">
								<div class="card">

									<div class="card-header">
										<h4>${product.productName }
											<span class="text-primary">Product Id</span> :
											${product.productId }
										</h4>
									</div>
									<div class="card-body">
										<h5 class="card-title">${product.title }</h5>

										<p class="card-text">${product.summary }
											<span class="text-primary">Price </span>: ${product.price }<span
												class="text-primary"> Making Charges </span>:
											${product.makingCharge}
										</p>
									</div>
									<div class="card-footer">
										<h1>hey</h1>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</c:forEach>
		</div>
	</div>
</div>

<jsp:include page="/include/footer.jsp" />