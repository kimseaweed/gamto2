package com.mrmr.gamto.utils;

import org.springframework.ui.Model;

public class AlertUtil {
    public static Model HeaderAlert(Model model, String message) {
        return model.addAttribute("headerAlert", message);
    }
    public static Model HeaderAlertError(Model model) {
        return model.addAttribute("headerAlert", "오류가 발생했습니다. 다시 시도해 주세요.");
    }


    public static Model HeaderAlertR(Model model, String message) {
        return model.addAttribute("headerAlertR", message);
    }
    public static Model HeaderAlertRError(Model model) {
        return model.addAttribute("headerAlertR", "오류가 발생했습니다. 다시 시도해 주세요.");
    }

    public static Model HeaderAlertB(Model model, String message) {
        return model.addAttribute("headerAlertB", message);
    }
    public static Model HeaderAlertY(Model model, String message) {
        return model.addAttribute("headerAlertY", message);
    }
}
