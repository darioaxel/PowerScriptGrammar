package org.darioaxel.util;

import org.eclipse.gmt.modisco.omg.kdm.code.AbstractCodeElement;
import org.eclipse.gmt.modisco.omg.kdm.code.ClassUnit;
import org.eclipse.gmt.modisco.omg.kdm.code.CodeModel;
import org.eclipse.gmt.modisco.omg.kdm.code.CompilationUnit;
import org.eclipse.gmt.modisco.omg.kdm.code.Datatype;
import org.eclipse.gmt.modisco.omg.kdm.code.LanguageUnit;
import org.eclipse.gmt.modisco.omg.kdm.code.MemberUnit;
import org.eclipse.gmt.modisco.omg.kdm.code.MethodUnit;
import org.eclipse.gmt.modisco.omg.kdm.source.SourceFile;

public final class CodeModelUtil {

	public static void addMethodToClassUnit(String unitClassName, MethodUnit method, CodeModel codeModel) {
		
		for(AbstractCodeElement e : codeModel.getCodeElement()) {
			if (e instanceof CompilationUnit ) {
				CompilationUnit cu = (CompilationUnit) e;
				for(AbstractCodeElement ee : cu.getCodeElement()) {
					if ( ee.getName().equals(unitClassName) && ee instanceof ClassUnit) {
						((ClassUnit) ee).getCodeElement().add(method);
					}
				}
			}			
		}		
	}
		
	public static String getClassUnitName(CodeModel codeModel, SourceFile source) {
		String[] parts = source.getName().split("\\.");
		return parts[0];
	}

	public static void addMemberUnitToClassUnit(MemberUnit member, String unitClassName, CodeModel codeModel) {
		
		for(AbstractCodeElement e : codeModel.getCodeElement()) {
			if (e instanceof CompilationUnit ) {
				CompilationUnit cu = (CompilationUnit) e;
				for(AbstractCodeElement ee : cu.getCodeElement()) {
					if ( ee.getName().equals(unitClassName) && ee instanceof ClassUnit) {
						((ClassUnit) ee).getCodeElement().add(member);
					}
				}
			}
		}
	}

	public static MemberUnit getMemberUnit(String memberName, CodeModel codeModel) {
		MemberUnit member = null;
		
		for(AbstractCodeElement e : codeModel.getCodeElement()) {
			if (e instanceof CompilationUnit ) {
				CompilationUnit cu = (CompilationUnit) e;
				for(AbstractCodeElement ee : cu.getCodeElement()) {				
					if (ee instanceof ClassUnit) {
						ClassUnit clu = (ClassUnit) ee;
						for(AbstractCodeElement eee : clu.getCodeElement()) {
							if (ee instanceof MemberUnit) {
								if (((MemberUnit) ee).getName().equals(memberName)) {
									return (MemberUnit) ee; 
								}
							}
						}
					}
				}
			}
		}
		return member;
	}

	public static ClassUnit getClassByName(String unitClassName, CodeModel codeModel) {

		for(AbstractCodeElement e : codeModel.getCodeElement()) {
			if (e instanceof CompilationUnit ) {
				CompilationUnit cu = (CompilationUnit) e;
				for(AbstractCodeElement ee : cu.getCodeElement()) {
					if ( ee.getName() == unitClassName && ee instanceof ClassUnit) {
						return (ClassUnit) ee;
					}
				}
			}			
		}	
		return null;
	}

	public static Datatype getDatatypeOfMember(String paramTypeName, String unitClassName, CodeModel codeModel) {
		
		ClassUnit classUnit = getClassByName(unitClassName, codeModel);
		
		for(AbstractCodeElement e : classUnit.getCodeElement()) {
			if (e.getName() == paramTypeName && e instanceof MemberUnit ) {
				return (Datatype) e;
			}
		}
		
		return null;
	}

	public static LanguageUnit getLanguageUnit(CodeModel codeModel,	SourceFile source) {
		
		CompilationUnit compUnit = getCompilationUnitByName(codeModel , source.getName());
		if (compUnit == null) return null;
		
		for(AbstractCodeElement e : compUnit.getCodeElement()) {
			if (e instanceof LanguageUnit ) {
				return (LanguageUnit) e;
			}
		}
		return null;
	}	
	
	public static CompilationUnit getCompilationUnitByName(CodeModel codeModel , String compilationName) {
		for(AbstractCodeElement e : codeModel.getCodeElement()) {
			if (e instanceof CompilationUnit && e.getName().equals(compilationName)) {
				return (CompilationUnit) e;
			}
		}
		return null;
	}
}
