package com.mrmr.gamto.help;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface HelpDAO {
	public int insertAskDao(@Param("dto")AskDTO dto); 
	public int insertAccuseDao(@Param("dto")AccuseDTO dto); 
}
