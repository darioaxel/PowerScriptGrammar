package org.darioaxel.mapper.source;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;

import org.darioaxel.mapper.KDMElementFactory;
import org.darioaxel.util.FileUtils;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.emf.common.util.EList;
import org.eclipse.gmt.modisco.omg.kdm.code.CodeAssembly;
import org.eclipse.gmt.modisco.omg.kdm.code.Package;
import org.eclipse.gmt.modisco.omg.kdm.kdm.Stereotype;
import org.eclipse.gmt.modisco.omg.kdm.source.InventoryModel;
import org.junit.Before;
import org.junit.Test;

public class InventoryModelCreatorTest {

	
	@Test
	public void createInventoryModelCreatorFromShouldWork() {

		File directory = new File("../PowerScriptGrammar/resources/inventoryModel/");
		InventoryModel inventoryModel = new InventoryModels().create(directory);
		assertEquals(inventoryModel.eContents().size(), 1);		
	  }
	/*
	@Test
	public void saveInventoryModelToFileShouldWork() {
		File directory = new File("../PowerScriptGrammar/resources/inventoryModel/");
		InventoryModel inventoryModel = new InventoryModels().create(directory);
		
		FileUtils.saveEcoreToXMI(inventoryModel, "../PowerScriptGrammar/result.xmi");		
	}
	*/
	@Test
	public void saveInventoryModelToFileShouldWork2() {
		File directory = new File("../PowerScriptGrammar/resources/advanced/real/myproject");
		InventoryModel inventoryModel = new InventoryModels().create(directory);
		
		FileUtils.saveEcoreToXMI(inventoryModel, "../PowerScriptGrammar/result2.xmi");
	}
	
	@Test
	public void searchInventoryModelCodeAssemblyShouldWork() {
		File directory = new File("../PowerScriptGrammar/resources/inventoryModel/");
		InventoryModel inventoryModel = new InventoryModels().create(directory);
		
		EList<Stereotype> e = inventoryModel.getStereotype();
		for(Stereotype sType : e){
			System.out.println(sType.getType());
		}
	}
	
	@Test
	public void otherTest() {
	//	CodeAssembly cAss = KDMElementFactory.createCodeAssembly();
	//	Package pac = KDMElementFactory.createPackage();
	//	cAss.getCodeElement().add(pac);
	}
	
}
