package com.shop.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.model.Addressess;
import com.shop.model.CustomerOrders;
import com.shop.model.Products;
import com.shop.model.ShoppingCart;
import com.shop.model.Users;
import com.shop.repository.CustomerOrdersRepository;
import com.shop.repository.ProductRepository;
import com.shop.repository.ShoppingCartRepository;
import com.shop.service.UserService;

@Controller
@SessionAttributes({"itemlist","o_id"})
public class ShoppingController {
	
	@Autowired
	private ShoppingCartRepository shoppingCartRepository;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProductRepository productRepository;
		
	@Autowired
	private CustomerOrdersRepository customerOrdersRepository;
	
	//@Autowired
	//private WebApplicationContext appContext;
	
	
	@GetMapping("shop")
	String shop(Model model) {
		//model.addAttribute("msg", "Shop");
		model.addAttribute("list", productRepository.findAll());
		return "shop";	
	}
	
	
	@GetMapping("productdetails")
	String sigle(@RequestParam Long id, Model model) {
		
		List<Products> p=productRepository.findAll();
		
		List<Products> itemList = p
				  .stream()
				  .filter(a->a.getId().equals(id))
				  .collect(Collectors.toList());
		
		model.addAttribute("item", itemList.get(0));
		model.addAttribute("list", p);
		
		return "sigle-product";	
	}
	
	@PostMapping("addtobag")
	String add(@ModelAttribute ShoppingCart shoppingCart,
			@SessionAttribute(required = false) Long o_id, Model model) {
	 
		try {
			  Products prd= productRepository.findById(shoppingCart.getProd_id()).get();
			  
		      if(o_id==null || o_id==0 ){
		    	CustomerOrders customerOrder=new CustomerOrders();		    	
		    	customerOrdersRepository.save(customerOrder); 		    	
		    	customerOrder.setId(customerOrder.getId());
		    	shoppingCart.setCustomerOrders(customerOrder);
				shoppingCart.setProduct(prd);
				shoppingCart.setAmount(shoppingCart.getQty()*(prd.getPrice()));	    		 
				shoppingCart.setAmount(prd.getPrice());
				shoppingCartRepository.save(shoppingCart);			   
			    model.addAttribute("o_id", customerOrder.getId()); 			    
			   
		       }else {
		      
		    	  Optional<CustomerOrders> order= customerOrdersRepository.findById(o_id);
		    	  Optional<ShoppingCart> unique= order.get().getCart().stream().filter(a->
				  a.getColor().equals(shoppingCart.getColor()) &&
				  a.getSize().equals(shoppingCart.getSize())).findFirst();
		    	  
		    	  unique.ifPresent(c->{ 		    		  
		    		  int qty=shoppingCart.getQty()+c.getQty(); 
		    		  double amount=qty*(prd.getPrice()); 
		    		  c.setId(unique.get().getId());
		    		  c.setQty(qty);		    		 
		    		  c.setAmount(amount);
		    		  c.setCustomerOrders(order.get());
		    		  shoppingCartRepository.save(c);
		    		  });
		    	  
		    	  if(!unique.isPresent()) { 
		    		  shoppingCart.setAmount(shoppingCart.getQty()*(prd.getPrice()));
		    		  shoppingCart.setProduct(prd);
		    		  shoppingCart.setAmount(prd.getPrice());
		    		  shoppingCart.setCustomerOrders(order.get());		    		 
				      shoppingCartRepository.save(shoppingCart);
		    	  }
				  
		    	
		       }
			 
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:cart";
	}
	
	// give me cart
	 @GetMapping("/cart") 
	  public String basket(@SessionAttribute(required = false) Long o_id, Model model) {
	  
	  try {
		  CustomerOrders ord=customerOrdersRepository.findById(o_id).get();
		  if(ord==null){
			  model.addAttribute("itemlist", "");  
		  }else {
		  model.addAttribute("itemlist", ord.getCart());
		  }
		  model.addAttribute("productList", productRepository.findAll());
	      model.addAttribute("page", "Cart");
	  } catch (Exception e) {
	  model.addAttribute("error", "");
	  
	  }
		return "cart";	
	}
	
	@GetMapping("checkout")
	String checkout(Model model,  @SessionAttribute(required=false) Long o_id) {
		Optional<CustomerOrders> order= customerOrdersRepository.findById(o_id);
		
		if(order.isPresent()) {
		model.addAttribute("order", order);		
		}
		return "checkout";	
	}
	
	@GetMapping("deleteorder")
	String deleteorder(@RequestParam Long id, RedirectAttributes model) {
		
		customerOrdersRepository.deleteById(id);
		model.addFlashAttribute("msg", "Order deleted");
		return "redirect:/cutomerOrders";	
	}
	
	@GetMapping("checkingout")
	String checkingout(Model model, RedirectAttributes red,  Principal principal) {
		Optional<Users> usr=userService.findByEmail(principal.getName());
		
		if(usr.get().getAddress()==null) {
			
			red.addFlashAttribute("_profile", "active"); 
			red.addFlashAttribute("user_account", usr.get());
			red.addFlashAttribute("msg", "Please Add Shipping Address");
			
			return "redirect:profile";	
		}
		
		usr.ifPresent(
				a->{
					Addressess add=usr.get().getAddress();
					CustomerOrders order=new CustomerOrders();
					order.setCity(add.getCity());
					order.setEmail(principal.getName());
					order.setPhone(add.getPhone());
					order.setState(add.getState());
					order.setStreet(add.getStreet());
					order.setZip(add.getZip());
					order.setCreatedon(new Date());	
				    order.setStatus("Proccessing");
					order.setFull_name(a.getFname()+" "+a.getLname());
					customerOrdersRepository.save(order);	
					model.addAttribute("order", order);
				}
		);
		
		
		return "checkout";	
	}
	
	
	@GetMapping("cutomerOrders")
	String cutomerOrders(Model model) {
		model.addAttribute("orderlist", customerOrdersRepository.findAll());
		return "cutomerOrders";	
	}
	
	@GetMapping("myorders")
	String myorders(Model model, Principal principal) {
		
		try {
		   model.addAttribute("orderlist", customerOrdersRepository.myOrders(principal.getName()));
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/profile";
		}
		
		return "cutomerOrders";	
	}
	
	
	@GetMapping("deleteItem")
	String remove(Model model, @RequestParam long id) {
		
		shoppingCartRepository.deleteById(id);
		
		return "redirect:/cart";	
	}
	
	@GetMapping("emptycart")
	String remove(Model model, @SessionAttribute(required=false) Long o_id) {
		
		customerOrdersRepository.deleteById(o_id);		
		model.addAttribute("itemlist", "");
		model.addAttribute("o_id", 0);
		
		return "redirect:/cart";	
	}
	
	
	
	@GetMapping("updateQty")
	String updateQty(@RequestParam Long id, @RequestParam int qty, Model model, @SessionAttribute(required=false) Long o_id) {
		
		try {
			shoppingCartRepository.findById(id).ifPresent(a->{
				a.setQty(qty);
				shoppingCartRepository.save(a);
			});
			model.addAttribute("itemlist", customerOrdersRepository.findById(o_id));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return "redirect:cart";	
	}
	
	//confirm order
	@PostMapping("confirmation")
	String confirmation(@ModelAttribute CustomerOrders order,
				Model model, @SessionAttribute(required=false) Long o_id) {
	 
		try {
			customerOrdersRepository.findById(o_id).ifPresent(o->{
				   order.setAmount(o.getCart().stream().mapToDouble(a->a.getAmount()).sum());
				   order.setQty(o.getCart().stream().mapToInt(a->a.getQty()).sum());
				   order.setStatus("Complete");	
			       order.setId(o_id);
			       order.setCart(o.getCart());
				   customerOrdersRepository.save(order);
				   model.addAttribute("itemlist", "");
				   model.addAttribute("o_id", 0);
				
			});
			
			   
			} catch (Exception e) {
				e.printStackTrace();
			}
		
	    return "confirmation";
	}
	//drop down selects
	@ModelAttribute("shoes")
	public List<String> shoe() {
		List<String> size = new ArrayList<String>();
		size.add("38");
		size.add("39");
		size.add("40");
		size.add("41");
		size.add("42");
		return size;
	}

	@ModelAttribute("size")
	public List<String> size() {
		List<String> size = new ArrayList<String>();
		size.add("S");
		size.add("M");		
		size.add("L");
		size.add("XL");
		size.add("2X");
		size.add("3X");		
		size.add("FREE SIZE");
		return size;
	}

	@ModelAttribute("col")
	public List<String> colour() {
		List<String> col = new ArrayList<String>();
		col.add("Blue");
		col.add("Brown");
		col.add("Black");
		col.add("White");
		col.add("Green");
		col.add("Gray");
		col.add("Red");
		col.add("Yellow");
		col.add("Pink");
		col.add("Tan");
		col.add("Purple");
		col.add("Maroon");
		col.add("Gold");
		col.add("Silver");
		return col;
	}
	
	
	//add modelAttrinute to the form
	@ModelAttribute("shoppingcart")
	ShoppingCart shop() {	
	ShoppingCart cart=new ShoppingCart();
	return cart;
	}

}
