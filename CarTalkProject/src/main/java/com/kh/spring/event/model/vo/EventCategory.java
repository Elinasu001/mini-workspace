package com.kh.spring.event.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class EventCategory {
    private int categoryNo;			// 카테고리 번호(FK, CT_EVENT_CATEGORY 참조)
    private String categoryName;	// 카테고리 이름 (1 : 시즌 이벤트 / 2 : 회원 이벤트 / 3: 리뷰 이벤트 / 4: 출석 이벤트)
}
