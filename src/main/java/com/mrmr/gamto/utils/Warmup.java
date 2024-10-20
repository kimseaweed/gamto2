package com.mrmr.gamto.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Slf4j
@Component
public class Warmup {
    // 어플리케이션이 초기화를 마치고 준비가 완료된 시점에 호출되는 메소드 @
    @EventListener(ApplicationReadyEvent.class)
    public void loadPagesOnStartup() {
        log.info("Warm up Start............");

        //스프링제공의 http클라이언트. 여기서 url을 호출할 때 사용
        RestTemplate restTemplate = new RestTemplate();

        String domain = "https://gamto.kro.kr";
        // 호출할 페이지 URL 목록
        List<String> pageUrls = Arrays.asList(
                "/",
                "/report/new",
                "/report",
                "/board",
                "/board/writeForm",
                "/store",
                "/admin"
                );

        for (String url : pageUrls) {
            try {
                String response = restTemplate.getForObject(domain+url, String.class);
                log.info("Loaded page: " + url);
            } catch (Exception e) {
                log.error("Failed to load page: " + url);
                e.printStackTrace();
            }
        }

        log.info("Warm up End............");
    }
}