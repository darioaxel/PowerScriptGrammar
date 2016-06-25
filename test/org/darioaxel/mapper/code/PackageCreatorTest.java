package org.darioaxel.mapper.code;

import static org.junit.Assert.*;

import java.io.File;

import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.gmt.modisco.omg.kdm.source.InventoryModel;
import org.eclipse.gmt.modisco.omg.kdm.code.CodeFactory;
import org.eclipse.gmt.modisco.omg.kdm.code.Package;
import org.eclipse.gmt.modisco.omg.kdm.code.CodePackage;
import org.eclipse.gmt.modisco.omg.kdm.code.impl.PackageImpl;
import org.eclipse.gmt.modisco.omg.kdm.source.SourceFactory;
import org.junit.Test;

public class PackageCreatorTest {

	private static final CodeFactory	CODE_FACTORY				= CodeFactory.eINSTANCE;

	@Test
	public void testingPackageCreator() {
		
		Package newPBG = CODE_FACTORY.createPackage();
		newPBG.createAggregation(arg0);
	}
}
