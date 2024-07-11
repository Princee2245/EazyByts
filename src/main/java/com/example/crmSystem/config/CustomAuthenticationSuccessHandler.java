package com.example.crmSystem.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        String role = authentication.getAuthorities().iterator().next().getAuthority();
        if ("ROLE_MANAGER".equals(role)) {
            response.sendRedirect("/manager/home");
        } else if ("ROLE_SALES_PERSON".equals(role)) {
            response.sendRedirect("/sales/home");
        } else {
            response.sendRedirect("/login?error=true");
        }
    }
}
