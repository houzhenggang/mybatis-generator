<#if mybatis.daoPackage??>
package ${mybatis.daoPackage};
</#if>

import java.util.List;
import org.apache.ibatis.annotations.Param;
<#if (mybatis.daoPackage!=mybatis.beanPackage)>
import ${mybatis.className};
</#if>

public interface ${mybatis.daoClassName} {

	public int add${mybatis.classSimpleName}(@Param("obj")${mybatis.classSimpleName} obj);

<#--unique operation 包含主键-->
<#list mybatis.uniques as u>
	<#--UNIQUE SELECT-->
	<#if u.select>
	public ${mybatis.classSimpleName} getBy${u.name}(
	<#assign idx=0>
	<#list u.columns as c>
	@Param("${c.property}")${c.type} ${c.property}
	<#assign idx=idx+1>
	<#if (idx<u.columns?size)>,</#if>
	</#list>
	);
	</#if>
	
	<#--UNIQUE UPDATE-->
	<#if u.update>
	public int updateBy${u.name}(@Param("obj")${mybatis.classSimpleName} obj);
	</#if>
	
	<#--UNIQUE DELETE-->
	<#if u.delete>
	public int deleteBy${u.name}(
	<#assign idx=0>
	<#list u.columns as c>
	@Param("${c.property}")${c.type} ${c.property}
	<#assign idx=idx+1>
	<#if (idx<u.columns?size)>,</#if>
	</#list>
	);
	</#if>
</#list>

<#--inde operation-->
<#list mybatis.indexes as index>
	<#--select one-->
	<#if index.selectOne>
	public ${mybatis.classSimpleName} getOneBy${index.name}(
	<#assign idx=0>
	<#list index.columns as c>
	@Param("${c.property}")${c.type} ${c.property}
	<#assign idx=idx+1>
	<#if (idx<index.columns?size)>,</#if>
	</#list>
	);
	</#if>
	
	<#--index limit offset-->
	<#if index.limitOffset>
	public List<${mybatis.classSimpleName}> getListBy${index.name}(
	<#assign idx=0>
	<#list index.columns as c>
	@Param("${c.property}")${c.type} ${c.property}
	<#assign idx=idx+1>
	<#if (idx<index.columns?size)>,</#if>
	</#list>
	,@Param("limit")int limit,@Param("offset") int offset);
	</#if>
	
	<#--index count--->
	<#if index.count>
	public long getCountBy${index.name}(
	<#assign idx=0>
	<#list index.columns as c>
	@Param("${c.property}")${c.type} ${c.property}
	<#assign idx=idx+1>
	<#if (idx<index.columns?size)>,</#if>
	</#list>
	);
	</#if>
</#list>

}