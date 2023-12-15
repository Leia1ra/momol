package com.example.momol;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
class MomolApplicationTests {

    @Test
    void contextLoads() {

        LocalDate today = LocalDate.now();
        List<LocalDate> dayList = new ArrayList<>();

        for ( int i = 0; i < 10; i++ ) {
            LocalDate day = today.minusDays(i);
            dayList.add(day);
        }
        for (LocalDate date : dayList) {
            System.out.println(date);
            System.out.println(date.getYear());
            System.out.println(date.getMonthValue());
            System.out.println(date.getDayOfMonth());
        }

    }

}
