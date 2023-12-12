package com.example.momol.Service;

import com.example.momol.DTO.BusinessVO;
import com.example.momol.DTO.UserVO;

public interface BusinessService {
    BusinessVO businessSelectbyUID(String UID);

}