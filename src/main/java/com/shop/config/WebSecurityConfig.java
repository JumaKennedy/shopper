package com.shop.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.session.HttpSessionEventPublisher;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
   
	@Autowired
    private UserDetailsService userDetailsService;
	
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
   
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .authorizeRequests()
                .antMatchers("/","/register","/login","/index","/contact","/about","/services","/shop","/cart",
                		     "/sendemail","/clientsay","/productdetails","/addtobag","/checkout","/deleteorder",
                		     "/checkingout","/deleteItem","/emptycart","/updateQty","/confirmation","/users",
                		     "/search").permitAll()
                
                .antMatchers("/cutomerOrders","/activate","/editrole","/saveproduct","/editproduct","/deleteproduct","/delete")
                .hasAnyAuthority("ADMIN","DBA")
                
                .antMatchers("/profile","/myorders","/addcoment","/addcoment","/addimages",
                			 "/addcoment","/updatecontact","/addcard","/addphone","/deletephone","/deletecard","/logout").
                hasAnyAuthority("ADMIN","USER","DBA").anyRequest()
                
                .authenticated().and().csrf().disable()
                .formLogin()
                .loginPage("/login").failureUrl("/login?error=true")
                .defaultSuccessUrl("/profile")                
                .usernameParameter("email")
                .passwordParameter("password")
                .and()
                .logout().permitAll();
                
                
    }
    
   
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**", "/static/**");
    }
    
    
    @Bean
    public AuthenticationManager customAuthenticationManager() throws Exception {
        return authenticationManager();
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder());
    }
    
    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }
    
    
    
}