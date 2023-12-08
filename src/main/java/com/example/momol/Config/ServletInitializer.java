package com.example.momol.Config;

import com.example.momol.MomolApplication;
import org.apache.catalina.Context;
import org.apache.tomcat.util.descriptor.web.JspConfigDescriptorImpl;
import org.apache.tomcat.util.descriptor.web.JspPropertyGroup;
import org.apache.tomcat.util.descriptor.web.JspPropertyGroupDescriptorImpl;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.util.Collections;


@Component
public class ServletInitializer extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(MomolApplication.class);
    }
    
    @Bean
    public ConfigurableServletWebServerFactory configurableServletWebServerFactory(){
        return new TomcatServletWebServerFactory(){
            @Override
            protected void postProcessContext(Context context){
                super.postProcessContext(context);
                JspPropertyGroup jpg = new JspPropertyGroup();
                jpg.addUrlPattern("*.jsp");
                jpg.addUrlPattern("*.jspf");
                jpg.setPageEncoding("UTF-8");
                // jpg.setScriptingInvalid("true");
                jpg.addIncludePrelude("/WEB-INF/inc/header.jspf");
                jpg.addIncludeCoda("/WEB-INF/inc/footer.jspf");
                jpg.setTrimWhitespace("true");
                jpg.setDefaultContentType("text/html");
                JspPropertyGroupDescriptorImpl j = new JspPropertyGroupDescriptorImpl(jpg);
                context.setJspConfigDescriptor(new JspConfigDescriptorImpl(Collections.singletonList(j),Collections.emptyList()));
            }
        };
    }
}
