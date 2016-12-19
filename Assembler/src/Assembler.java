import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Hashtable;

public class Assembler {

	private static Hashtable<String, String> opcode;
	private static StringBuilder machineCode;

	public static void main(String... args) throws IOException {
		BufferedReader input = new BufferedReader(new FileReader("assembly_code.txt"));
		BufferedWriter output = new BufferedWriter(new FileWriter("machine_code.txt"));
		String instruction = null;
		opcode = new Hashtable<String, String>();
		machineCode = new StringBuilder();
		initialTable();

		while ((instruction = input.readLine()) != null)
			machineCode.append(parse(instruction)).append("\n");

		System.out.print(machineCode);
		output.write(machineCode.toString());
		input.close();
		output.close();
	}

	private static String parse(String instruction) {
		StringBuilder code = new StringBuilder();
		String[] element = instruction.split(" ");

		code.append(opcode.get(element[0]));
		code.append("0");

		code.append(String.format("%03d", toBinary(element[1].substring(1, element[1].length()))));

		if (element[2].equals("rx"))
			code.append("000");
		else
			code.append(String.format("%03d", toBinary(element[2].substring(1, element[2].length()))));

		if (element[3].charAt(0) == '#')
			code.append(String.format("%04d", toBinary(element[3].substring(1, element[3].length()))));
		else
			code.append(String.format("%03d", toBinary(element[3].substring(1, element[3].length()))));

		if (element[0].charAt(element[0].length() - 1) != 'I')
			code.append("0");

		code.insert(8, " ");
		return code.toString();
	}

	private static int toBinary(String value) {
		return Integer.parseInt(Integer.toBinaryString(Integer.parseInt(value)));
	}

	private static void initialTable() {
		opcode.put("ADD", "00000");
		opcode.put("ADDI", "00001");
		opcode.put("MOV", "00010");
		opcode.put("MOVI", "00011");
		opcode.put("SUB", "00100");
		opcode.put("SUBI", "00101");
		opcode.put("SHL", "00110");
		opcode.put("SHLI", "00111");
		opcode.put("ASR", "01000");
		opcode.put("ASRI", "01001");
		opcode.put("LSR", "01010");
		opcode.put("LSRI", "01011");
		opcode.put("ROL", "01100");
		opcode.put("ROLI", "01101");
		opcode.put("ROR", "01110");
		opcode.put("RORI", "01111");
		opcode.put("AND", "10000");
		opcode.put("ANDI", "10001");
		opcode.put("OR", "10010");
		opcode.put("ORI", "10011");
		opcode.put("NOT", "10110");
		opcode.put("MULT", "11000");
		opcode.put("MULTI", "11001");
	}
}