package com.psu.projectmethod.domain;

import java.io.Serializable;

public enum Status implements Serializable {
    _1_BACKLOG,
    _2_TO_DO,
    _3_IN_PROGRESS,
    _4_DONE,
    _5_ON_CHECK,
    _6_VERIFIED,
    _7_COMPLETED;

    @Override
    public String toString() {
        return name();
    }
}
