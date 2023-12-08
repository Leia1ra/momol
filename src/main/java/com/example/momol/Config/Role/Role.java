package com.example.momol.Config.Role;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Role {
    GENERAL("ROLE_GENERAL"),
    BUSINESS("ROLE_BUSINESS"),
    ADMIN("ROLE_ADMIN");

    private final String key;
}
