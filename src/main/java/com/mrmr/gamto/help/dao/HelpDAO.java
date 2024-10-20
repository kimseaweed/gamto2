package com.mrmr.gamto.help.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mrmr.gamto.help.dto.AccuseDTO;
import com.mrmr.gamto.help.dto.AskDTO;

@Mapper
public interface HelpDAO {
	public int insertAskDao(@Param("dto")AskDTO dto); 
	public int insertAccuseDao(@Param("dto")AccuseDTO dto); 
}
