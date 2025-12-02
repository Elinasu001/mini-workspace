package com.kh.spring.main.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.spring.event.model.dto.EventDTO;
import com.kh.spring.event.model.service.EventService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MainController {

    private final EventService eventService;
    
    /** 메인 페이지용 진행중 이벤트 조회 */
    @GetMapping("/main")
    public String main(Model model) {
        List<EventDTO> ongoingEvents = eventService.selectEventOngoingTop();
        model.addAttribute("ongoingEvents", ongoingEvents);
        return "main";
    }
}
