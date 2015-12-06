
<%
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>

<portlet:defineObjects />

<aui:form action="/abc" method="post" name="form" onsubmit='<%= "event.preventDefault();" + renderResponse.getNamespace() + "validateForm();" %>'>
	<aui:select label="" id="SimpleTermDropDown" name="SimpleTermDropDown">
		<aui:option selected="true" value="-1">
			<liferay-ui:message key="Choose a Data Type" />
		</aui:option>
		<aui:option value="integer">
			<liferay-ui:message key="Integer" />
		</aui:option>
		<aui:option value="long">
			<liferay-ui:message key="Long" />
		</aui:option>
		<aui:option value="string">
			<liferay-ui:message key="String" />
		</aui:option>
	</aui:select>
	<aui:input name="test">
		<aui:validator name="required"></aui:validator>
	</aui:input>
	<aui:input name="test2" />
	<aui:button cssClass="save" value="Save" type="submit"></aui:button>
</aui:form>

<aui:script use="aui-form-validator,liferay-form">
var select = function(val, node, ruleValue) {
	if(val == -1){
		return false;
	}
	return true;
}

var DEFAULTS_FORM_VALIDATOR = A.config.FormValidator;

A.mix(DEFAULTS_FORM_VALIDATOR.RULES, {
	select : select
}, true);

Liferay.provide(
	window,
	'<portlet:namespace />validateForm',
	function() {
		var form = Liferay.Form.get('<portlet:namespace />form');
		var formValidator = form.formValidator;
		var rules = formValidator.get('rules');
		rules['<portlet:namespace />SimpleTermDropDown'] = {select:select};
		formValidator.validate();
		if (formValidator.hasErrors()) {
			return;
		}
		submitForm(document.<portlet:namespace />form);
	}
);
</aui:script>